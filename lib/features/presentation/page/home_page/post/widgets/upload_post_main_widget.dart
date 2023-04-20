import 'package:petopia/features/domain/entities/post/post_entity.dart';
import 'package:petopia/features/domain/entities/user/user_entity.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/storage/upload_image_to_storage_usecase.dart';
import 'package:petopia/features/presentation/cubit/post/post_cubit.dart';
import 'package:petopia/features/presentation/page/profile/widget/profile_form_widget.dart';
import 'package:petopia/injection_container.dart' as di;
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petopia/profile_widget.dart';
import 'package:petopia/util/consts.dart';
import 'package:uuid/uuid.dart';

class UploadPostMainWidget extends StatefulWidget {
  final UserEntity currentUser;
  const UploadPostMainWidget({super.key, required this.currentUser});

  @override
  State<UploadPostMainWidget> createState() => _UploadPostMainWidgetState();
}

class _UploadPostMainWidgetState extends State<UploadPostMainWidget> {
  final TextEditingController _descriptionController = TextEditingController();
  bool isUploading = false;
  File? _image;

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _image == null
        ? uploadPostWidget()
        : Scaffold(
            backgroundColor: white,
            appBar: AppBar(
              backgroundColor: darkPinkColor,
              leading: GestureDetector(
                onTap: () => setState(() {
                  _image = null;
                }),
                child: GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.close,
                  ),
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    _submitPost();
                  },
                  child: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    sizeVertical(10),
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: profileWidget(
                            imageUrl: widget.currentUser.profileUrl!),
                      ),
                    ),
                    sizeVertical(10),
                    Text(
                      widget.currentUser.username!,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    sizeVertical(10),
                    SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: profileWidget(image: _image),
                    ),
                    sizeVertical(10),
                    ProfileFormWidget(
                      title: "Description",
                      controller: _descriptionController,
                    ),
                    sizeVertical(10),
                    isUploading == true
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Uploading...",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              sizeHorizontal(10),
                              const CircularProgressIndicator(
                                color: Colors.pink,
                                strokeWidth: 10,
                              ),
                            ],
                          )
                        : const SizedBox(
                            width: 0,
                            height: 0,
                          )
                  ],
                ),
              ),
            ),
          );
  }

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

  _submitPost() {
    setState(() {
      isUploading = true;
    });
    di
        .sl<UploadImageToStorageUseCase>()
        .call(_image!, true, "posts")
        .then((value) {
      _createSubmitPost(image: value);
    });
  }

  _createSubmitPost({required String image}) {
    BlocProvider.of<PostCubit>(context)
        .createPost(
          post: PostEntity(
            description: _descriptionController.text.toString(),
            createAt: Timestamp.now(),
            creatorUid: widget.currentUser.uid,
            likes: const [],
            postId: const Uuid().v1(),
            postImageUrl: image,
            totalComments: 0,
            totalLikes: 0,
            username: widget.currentUser.username,
            userProfileUrl: widget.currentUser.profileUrl,
          ),
        )
        .then((value) => _clear());
  }

  _clear() {
    setState(() {
      _image = null;
      _descriptionController.clear();
      isUploading = false;
    });
  }

  uploadPostWidget() {
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: GestureDetector(
          onTap: () {
            selectImage();
          },
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
                color: darkPinkColor.withOpacity(.3),
                shape: BoxShape.circle
            ),
            child: Center(
              child: Icon(Icons.upload, color: darkPinkColor, size: 40,),
            ),
          ),
        ),
      ),
    );
  }
}
