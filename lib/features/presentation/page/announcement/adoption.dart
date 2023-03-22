import 'package:flutter/material.dart';
import 'package:petopia/util/consts.dart';

class AdoptionPage extends StatelessWidget {
  const AdoptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkYellowColor,
        title: const Text("Adoption"),
      ),
    );
  }
}
