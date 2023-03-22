import 'package:flutter/material.dart';
import 'package:petopia/features/presentation/page/credential/sign_up_page.dart';
import 'package:petopia/features/presentation/widgets/button_container_widget.dart';
import 'package:petopia/features/presentation/widgets/form_container_widget.dart';
import 'package:petopia/util/consts.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlueGreenColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(flex: 2, child: Container()),
            const Text(
              'Petopia',
              style: TextStyle(
                  color: black, fontSize: 30, fontWeight: FontWeight.bold),
            ),
            sizeVertical(30),
            const FormContainerWidget(
              hintText: 'Email',
              inputType: TextInputType.emailAddress,
            ),
            sizeVertical(10),
            const FormContainerWidget(
              hintText: 'Password',
              isPasswordField: true,
            ),
            sizeVertical(15),
            ButtonContainerWidget(
              color: darkBlueColor,
              text: 'Sign In',
              onTapListener: () {},
            ),
            Flexible(flex: 2, child: Container()),
            const Divider(
              color: black,
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpPage()),
                    );
                  },
                  child: const Text(" Sign Up",
                      style:
                          TextStyle(color: black, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
