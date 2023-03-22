import 'package:flutter/material.dart';
import 'package:petopia/util/consts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkOrangeColor,
        title: const Text("Home Page"),
      ),
    );
  }
}
