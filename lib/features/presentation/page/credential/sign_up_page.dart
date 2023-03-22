import 'package:flutter/material.dart';
import 'package:petopia/features/presentation/page/credential/sign_in.dart';

import '../../../../util/consts.dart';
import '../../widgets/button_container_widget.dart';
import '../../widgets/form_container_widget.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlueGreenColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: Container(),
            ),
            // Center(
            //   child: Image.asset("assets/profile_default.png"),

            // ),
            const SizedBox(height: 15),
            Expanded(
              child: Center(
                child: Stack(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30)),
                      child: Image.asset("assets/profile_default.png"),
                    ),
                    Positioned(
                      right: -10,
                      bottom: -15,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add_a_photo,
                          color: black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            const FormContainerWidget(
              hintText: "Username",
            ),
            const SizedBox(height: 15),
            const FormContainerWidget(
              hintText: "Email",
            ),
            const SizedBox(height: 15),
            const FormContainerWidget(
              hintText: "Password",
              isPasswordField: true,
            ),
            const SizedBox(height: 15),
            const FormContainerWidget(
              hintText: "Bio",
            ),
            const SizedBox(height: 15),
            ButtonContainerWidget(
              color: darkBlueColor,
              text: "Sign Up",
              onTapListener: () {},
            ),
            Flexible(
              flex: 2,
              child: Container(),
            ),
            const Divider(
              color: darkBlueColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account? ",
                  style: TextStyle(color: black),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignInPage()),
                        (route) => false);
                  },
                  child: const Text(
                    "Sign In.",
                    style: TextStyle(fontWeight: FontWeight.bold, color: black),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
