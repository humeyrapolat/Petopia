import 'package:flutter/material.dart';
import 'package:petopia/util/consts.dart';

class HiddenPostPage extends StatelessWidget {
  const HiddenPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: 24,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(1.0),
            child: Container(
              color: lightOrangeColor,
            ),
          );
        });
  }
}
