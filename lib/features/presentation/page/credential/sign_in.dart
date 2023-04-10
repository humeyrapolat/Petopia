import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petopia/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:petopia/features/presentation/cubit/credential/credential_cubit.dart';
import 'package:petopia/features/presentation/page/main_screen/main_screen.dart';
import 'package:petopia/features/presentation/widgets/form_container_widget.dart';
import 'package:petopia/util/consts.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isSignIn = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightPinkColor,
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
            inputType: TextInputType.emailAddress,
          ),
          sizeVertical(10),
          FormContainerWidget(
            controller: _passwordController,
            hintText: 'Password',
            isPasswordField: true,
          ),
          sizeVertical(15),
          ElevatedButton(
            onPressed: () => _isSignIn,
            style: ButtonStyle(
              elevation: MaterialStateProperty.all<double>(5),
              backgroundColor: MaterialStateProperty.all<Color>(darkPinkColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            child: const Text(
              "Sign In",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Flexible(flex: 2, child: Container()),
          const Divider(
            color: darkPinkColor,
            thickness: 1,
          ),
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
        ],
      ),
    );
  }

  void _signIn() {
    setState(() {
      _isSignIn = true;
    });

    BlocProvider.of<CredentialCubit>(context)
        .signInUser(
            email: _emailController.text, password: _passwordController.text)
        .then((value) => _clear());
  }

  _clear() {
    setState(() {
      _emailController.clear();
      _passwordController.clear();
      _isSignIn = false;
    });
  }
}
