import 'package:flutter/material.dart';
import 'package:petopia/features/presentation/page/profile/widget/profile_form_widget.dart';
import 'package:petopia/util/consts.dart';

class UpdatePostPage extends StatelessWidget {
  const UpdatePostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueColor,
      appBar: AppBar(
        backgroundColor: darkBlueColor,
        title: Text("Edit Post"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Icon(Icons.done, color: lightBlueColor, size: 28,),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: lightBlueColor,
                    shape: BoxShape.circle
                ),
              ),
              sizeVertical(10),
              Text("Username", style: TextStyle(color: lightBlueColor, fontSize: 16, fontWeight: FontWeight.bold),),
              sizeVertical(10),
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                    color: lightBlueColor
                ),
              ),
              sizeVertical(10),
              ProfileFormWidget(
                title: "Description",
              )
            ],
          ),
        ),
      ),
    );
  }
}
