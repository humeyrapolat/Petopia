import 'package:flutter/material.dart';
import 'package:petopia/util/consts.dart';

class MatchPage extends StatelessWidget {
  const MatchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkPinkColor,
        title: const Text("Match"),
      ),
    );
  }
}
