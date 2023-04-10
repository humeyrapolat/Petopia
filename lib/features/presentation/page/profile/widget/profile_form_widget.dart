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
        sizeVertical(10),
        TextFormField(
            cursorColor: Colors.lightGreen,
            keyboardType: TextInputType.text,
            controller: controller,
            decoration: InputDecoration(
              labelText: '$title',
              labelStyle:
                  const TextStyle(color: darkBlueGreenColor, fontSize: 16),
              hintText: "Enter your  $title",
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: darkBlueGreenColor,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(),
                borderRadius: BorderRadius.circular(15),
              ),
            )),
        Container(
          width: double.infinity,
          height: 1,
          color: lightBlueGreenColor,
        )
      ],
    );
  }
}
