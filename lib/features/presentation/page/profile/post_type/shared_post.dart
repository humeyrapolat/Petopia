import 'package:flutter/material.dart';
import 'package:petopia/util/consts.dart';

class SharedPostPage extends StatelessWidget {
  const SharedPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: 4,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(1.0),
            child: Container(
              color: lightBlueGreenColor,
            ),
          );
        });
  }
}
