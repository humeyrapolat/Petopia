import 'package:flutter/material.dart';
import 'package:petopia/util/consts.dart';

class UploadPostPage extends StatelessWidget {
  const UploadPostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightBlueColor,
        body: Center(
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
                color: darkPinkColor.withOpacity(.3), shape: BoxShape.circle),
            child: const Center(
              child: Icon(
                Icons.upload,
                color: darkBlueColor,
                size: 40,
              ),
            ),
          ),
        ));
  }
}
