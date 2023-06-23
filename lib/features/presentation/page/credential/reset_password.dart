import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
        leading: GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back)),
      ),
      backgroundColor: white,
      body: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, resetPasswordState) {
          if (resetPasswordState is ResetPasswordSuccess) {
            // Şifre sıfırlama başarılı olduğunda yapılacak işlemler
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Password Reset'),
                content: const Text('Password reset link sent! Check your email.'),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          } else if (resetPasswordState is ResetPasswordFailure) {
            // Şifre sıfırlama başarısız olduğunda yapılacak işlemler
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Password Reset'),
                content: const Text('Invalid Email. Please try again.'),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }
        },
        builder: (context, resetPasswordState) {
          return _buildBody();
        },
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter your email address to reset your password',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            FormContainerWidget(
              controller: _emailController,
              hintText: 'Email',
              inputType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
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
                'Reset Password',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _resetPassword() {
    final email = _emailController.text.trim();
    if (email.isNotEmpty) {
      BlocProvider.of<ResetPasswordCubit>(context).resetPasswordUseCase(email);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Reset Password'),
          content: const Text('Please enter your email.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
