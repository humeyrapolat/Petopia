import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petopia/features/domain/entities/user/user_entity.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/storage/upload_image_to_storage_usecase.dart';
import 'package:petopia/features/presentation/cubit/user/user_cubit.dart';
import 'package:petopia/features/presentation/page/profile/widget/profile_dropDown_widget.dart';
import 'package:petopia/features/presentation/page/profile/widget/profile_form_widget.dart';
import 'package:petopia/profile_widget.dart';
import 'package:petopia/util/consts.dart';
import 'package:petopia/injection_container.dart' as di;

class EditProfilePage extends StatefulWidget {
  final UserEntity currentUser;

  EditProfilePage({Key? key, required this.currentUser}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController? _nameController;
  TextEditingController? _usernameController;
  TextEditingController? _websiteController;
  TextEditingController? _typeController;
  TextEditingController? _genderController;
  TextEditingController? _breedController;
  TextEditingController? _bioController;

  final List<String> genderItems = [
    'Male',
    'Female',
  ];

  final List<String> typeItems = [
    'Cat',
    'Dog',
  ];

  final List<String> breedItems = [
    "Labrador Retriever",
    "German Shepherd",
    "Bulldog",
    "Poodle",
    "Golden Retriever",
    "Siamese",
    "Persian",
    "Maine Coon",
    "Bengal",
    "Sphynx",
  ];

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.currentUser.name);
    _usernameController =
        TextEditingController(text: widget.currentUser.username);
    _websiteController =
        TextEditingController(text: widget.currentUser.website);
    _typeController = TextEditingController(text: widget.currentUser.type);
    _genderController = TextEditingController(text: widget.currentUser.gender);
    _breedController = TextEditingController(text: widget.currentUser.breed);
    _bioController = TextEditingController(text: widget.currentUser.bio);
    super.initState();
  }

  bool _isUpdating = false;

  File? _image;

  Future selectImage() async {
    try {
      final pickedFile =
          await ImagePicker.platform.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print("no image has been selected");
        }
      });
    } catch (e) {
      toast("some error occured $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlueGreenColor,
      appBar: AppBar(
        backgroundColor: darkBlueGreenColor,
        title: const Text("Edit Profile"),
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.close,
              size: 32,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: _updateUserProfileData,
              child: const Icon(
                Icons.done,
                color: white,
                size: 32,
              ),
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
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: profileWidget(
                        imageUrl: widget.currentUser.profileUrl, image: _image),
                  ),
                ),
              ),
              sizeVertical(15),
              Center(
                child: GestureDetector(
                  onTap: selectImage,
                  child: const Text(
                    "Change profile photo",
                    style: TextStyle(
                        color: black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              sizeVertical(15),
              ProfileFormWidget(title: "Name", controller: _nameController),
              sizeVertical(15),
              ProfileFormWidget(
                  title: "Username", controller: _usernameController),
              sizeVertical(15),
              ProfileDropdownWidget(
                  title: "Type", controller: _typeController, list: typeItems),
              sizeVertical(15),
              ProfileDropdownWidget(
                title: "Breed",
                controller: _breedController,
                list: breedItems,
              ),
              sizeVertical(10),
              ProfileDropdownWidget(
                title: "Gender",
                controller: _genderController,
                list: genderItems,
              ),
              sizeVertical(10),
              ProfileFormWidget(
                  title: "Add Bio", controller: _bioController),
              sizeVertical(15),
              _isUpdating == true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Please wait...",
                          style: TextStyle(color: Colors.white),
                        ),
                        sizeHorizontal(10),
                        const CircularProgressIndicator()
                      ],
                    )
                  : Container(
                      width: 0,
                      height: 0,
                    )
            ],
          ),
        ),
      ),
    );
  }

  _updateUserProfileData() {
    setState(() => _isUpdating = true);
    if (_image == null) {
      _updateUserProfile("");
    } else {
      di
          .sl<UploadImageToStorageUseCase>()
          .call(_image!, false, "profileImages")
          .then((profileUrl) {
        _updateUserProfile(profileUrl);
      });
    }
  }

  _updateUserProfile(String profileUrl) {
    BlocProvider.of<UserCubit>(context)
        .updateUser(
            user: UserEntity(
                uid: widget.currentUser.uid,
                username: _usernameController!.text,
                type: _typeController!.text,
                gender: _genderController!.text,
                breed: _breedController!.text,
                website: _websiteController!.text,
                name: _nameController!.text,
                bio: _bioController!.text,
                profileUrl: profileUrl))
        .then((value) => _clear());
  }

  _clear() {
    setState(() {
      _isUpdating = false;
      _usernameController!.clear();
      _typeController!.clear();
      _genderController!.clear();
      _breedController!.clear();
      _websiteController!.clear();
      _nameController!.clear();
      _bioController!.clear();
    });
    Navigator.pop(context);
  }
}
