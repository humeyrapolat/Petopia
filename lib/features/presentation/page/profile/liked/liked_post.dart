import 'package:flutter/material.dart';
import 'package:petopia/features/domain/entities/animal/animal_entity.dart';
import 'package:petopia/util/consts.dart';

class LikedPostPage extends StatelessWidget {
  final AnimalEntity currentUser;

  const LikedPostPage({super.key, required this.currentUser});

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
              color: lightYellowColor,
            ),
          );
        });
  }
}
