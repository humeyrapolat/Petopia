import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petopia/features/presentation/cubit/resetPassword/reset_password_cubit.dart';

import '../../../../util/consts.dart';
import '../../widgets/form_container_widget.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkPurpleColor,
        title: const Text('Reset Password'),
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back)),
      ),
      backgroundColor: lightPurpleColor,
      body: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, resetPasswordState) {
          if (resetPasswordState is ResetPasswordSuccess) {
            BlocProvider.of<ResetPasswordCubit>(context)
                .passwordReset(email: _emailController.text);
          }
          if (resetPasswordState is ResetPasswordFailure) {
            toast("Invalid Email");
          }
        },
        builder: (context, credentialState) {
          if (credentialState is ResetPasswordSuccess) {
            return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
              builder: (context, resetPasswordState) {
                if (resetPasswordState is ResetPasswordSuccess) {
                  return const AlertDialog(
                    content:
                        Text("Password reset link sent! Check your email."),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Text(
            "Enter Your Email and we will send you a password reset link",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,),
            textAlign: TextAlign.center,
          ),
        ),
        sizeVertical(20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: FormContainerWidget(
            controller: _emailController,
            hintText: 'Email',
            inputType: TextInputType.emailAddress,
          ),
        ),
        sizeVertical(20),
        ElevatedButton(
          onPressed: () {
            _resetPassword();
          },
          style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>(5),
            backgroundColor: MaterialStateProperty.all<Color>(darkPurpleColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          child: const Text(
            "Reset Password",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

   _resetPassword() {
    BlocProvider.of<ResetPasswordCubit>(context)
        .passwordReset(email: _emailController.text)
        .then((value) => _clear());
  }

  _clear() {
    setState(() {
      _emailController.clear();
    });
  }
}
