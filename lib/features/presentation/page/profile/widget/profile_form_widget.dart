import 'package:flutter/material.dart';
import 'package:petopia/util/consts.dart';

class ProfileFormWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? title;
  const ProfileFormWidget({Key? key, this.title, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title",
          style: const TextStyle(color: lightBlueColor, fontSize: 16),
        ),
        sizeVertical(10),
        TextFormField(
          controller: controller,
          style: const TextStyle(color: lightBlueColor),
          decoration: const InputDecoration(
              border: InputBorder.none,
              labelStyle: TextStyle(color: lightBlueColor)),
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: lightBlueColor,
        )
      ],
    );
  }
}
