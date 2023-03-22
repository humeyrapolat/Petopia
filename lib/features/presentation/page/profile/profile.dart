import 'package:flutter/material.dart';
import 'package:petopia/util/consts.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkGreenColor,
        title: const Text("Profile"),
      ),
    );
  }
}
