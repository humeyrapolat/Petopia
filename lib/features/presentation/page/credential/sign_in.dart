import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petopia/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:petopia/features/presentation/cubit/credential/credential_cubit.dart';
import 'package:petopia/features/presentation/page/main_screen/main_screen.dart';
import 'package:petopia/features/presentation/widgets/form_container_widget.dart';
import 'package:petopia/util/consts.dart';
import 'package:petopia/util/validator.dart';

import 'styled_loading_screen.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  bool _autoFocus = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _checkIfTextFieldsEmpty() =>
      _emailController.text.isEmpty || _passwordController.text.isEmpty;

  void _onPasswordTextFieldSubmit(value) =>
      _checkIfTextFieldsEmpty() ? null : _signIn();

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const StyledLoadingScreen()
        : Scaffold(
            backgroundColor: white,
            body: BlocConsumer<CredentialCubit, CredentialState>(
              listener: (context, credentialState) {
                if (credentialState is CredentialSuccess) {
                  BlocProvider.of<AuthCubit>(context).loggedIn();
                }
                if (credentialState is CredentialFailure) {
                  toast("Invalid Email and Password");
                }
              },
              builder: (context, credentialState) {
                if (credentialState is CredentialSuccess) {
                  return BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, authState) {
                      if (authState is Authenticated) {
                        return MainScreen(
                          uid: authState.uid,
                        );
                      } else {
                        return _bodyWidget();
                      }
                    },
                  );
                }
                return _bodyWidget();
              },
            ),
          );
  }

  _bodyWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(flex: 2, child: Container()),
          const Text(
            'Petopia',
            style: TextStyle(
                color: darkPinkColor,
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          sizeVertical(30),
          FormContainerWidget(
            controller: _emailController,
            hintText: 'Email',
            autofocus: _autoFocus,
            validator: Validator.onEmailValidation,
            inputType: TextInputType.emailAddress,
          ),
          sizeVertical(10),
          FormContainerWidget(
            controller: _passwordController,
            hintText: 'Password',
            onFieldSubmitted: _onPasswordTextFieldSubmit,
            validator: Validator.onPasswordValidation,
            isPasswordField: true,
          ),
          sizeVertical(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, PageConsts.resetPasswordPage);
                },
                child: const Text("Forget Password",
                    style: TextStyle(
                      color: black,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ],
          ),
          sizeVertical(15),
          ElevatedButton(
            onPressed: _checkIfTextFieldsEmpty() ? null : () => _signIn(),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(darkPinkColor),
              elevation: MaterialStateProperty.all<double>(5),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            child: isLoading
                ? const CupertinoActivityIndicator()
                : const Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
          sizeVertical(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Already have an account?',
                style: TextStyle(color: black),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, PageConsts.signUpPage, (route) => false);
                },
                child: const Text(" Sign Up",
                    style: TextStyle(
                      color: darkPinkColor,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ],
          ),
          Flexible(flex: 2, child: Container()),
        ],
      ),
    );
  }

  Future<void> _signIn() async {
    if (!isLoading) {
      _autoFocus = false;
      setState(() {
        isLoading = true;
      });
      BlocProvider.of<CredentialCubit>(context)
          .signInUser(
              email: _emailController.text, password: _passwordController.text)
          .then((value) {
        _clear();
      });
    }
  }

  _clear() {
    setState(() {
      _emailController.clear();
      _passwordController.clear();
      isLoading = false;
    });
  }
}
