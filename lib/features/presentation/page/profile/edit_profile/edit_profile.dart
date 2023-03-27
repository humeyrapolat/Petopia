import 'package:flutter/material.dart';
import 'package:petopia/features/presentation/page/profile/widget/profile_form_widget.dart';
import 'package:petopia/util/consts.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueColor,
      appBar: AppBar(
        backgroundColor: darkBlueColor,
        title: const Text("Edit Profile"),
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.close,
              size: 32,
            )),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(
              Icons.done,
              color: darkBlueColor,
              size: 32,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: darkBlueColor,
                    borderRadius: BorderRadius.circular(60),
                  ),
                ),
              ),
              sizeVertical(15),
              const Center(
                child: Text(
                  "Change profile photo",
                  style: TextStyle(
                      color: darkBlueColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                ),
              ),
              sizeVertical(15),
              const ProfileFormWidget(title: "Name"),
              sizeVertical(15),
              const ProfileFormWidget(title: "Username"),
              sizeVertical(15),
              const ProfileFormWidget(title: "Website"),
              sizeVertical(15),
              const ProfileFormWidget(title: "Bio"),
            ],
          ),
        ),
      ),
    );
  }
}
