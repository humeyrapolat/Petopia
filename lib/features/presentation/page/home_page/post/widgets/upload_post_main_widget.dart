
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petopia/features/domain/entities/post/post_entity.dart';
import 'package:petopia/features/presentation/cubit/post/post_cubit.dart';
import 'package:petopia/util/consts.dart';
import 'package:petopia/features/domain/entities/user/user_entity.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/storage/upload_image_to_storage_usecase.dart';
import 'package:petopia/profile_widget.dart';
import 'package:uuid/uuid.dart';
import 'package:petopia/injection_container.dart' as di;

import '../../../profile/widget/profile_form_widget.dart';



class UploadPostMainWidget extends StatefulWidget {
  final UserEntity currentUser;
  const UploadPostMainWidget({Key? key, required this.currentUser}) : super(key: key);

  @override
  State<UploadPostMainWidget> createState() => _UploadPostMainWidgetState();
}

class _UploadPostMainWidgetState extends State<UploadPostMainWidget> {

  File? _image;
  TextEditingController _descriptionController = TextEditingController();
  bool _uploading = false;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future selectImage() async {
    try {
      final pickedFile = await  ImagePicker.platform.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print("no image has been selected");
        }
      });

    } catch(e) {
      toast("some error occured $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return _image == null? _uploadPostWidget() : Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: darkPinkColor,
        leading: GestureDetector(onTap: () => setState(() => _image = null),child: Icon(Icons.close, size: 28,)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(onTap: _submitPost,child: Icon(Icons.arrow_forward)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              child: ClipRRect(borderRadius: BorderRadius.circular(40),child: profileWidget(imageUrl: "${widget.currentUser.profileUrl}")),
            ),
            sizeVertical(10),
            Text("${widget.currentUser.username}", style: TextStyle(color: Colors.black),),
            sizeVertical(10),
            Expanded(
              child: Container(
                width: double.infinity,
                height: 250,
                child: profileWidget(image: _image),
              ),
            ),
            sizeVertical(10),
            ProfileFormWidget(title: "Description", controller: _descriptionController,),
            sizeVertical(10),
            _uploading == true?Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Uploading...", style: TextStyle(color: Colors.black),),
                sizeHorizontal(10),
                CircularProgressIndicator()
              ],
            ) : Container(width: 0, height: 0,)
          ],
        ),
      ),
    );
  }

  _submitPost() {
    setState(() {
      _uploading = true;
    });
    di.sl<UploadImageToStorageUseCase>().call(_image!, true, "posts").then((imageUrl) {
      _createSubmitPost(image: imageUrl);
    });
  }

  _createSubmitPost({required String image}) {
    BlocProvider.of<PostCubit>(context).createPost(
        post: PostEntity(
            description: _descriptionController.text,
            createAt: Timestamp.now(),
            creatorUid: widget.currentUser.uid,
            likes: [],
            postId: Uuid().v1(),
            postImageUrl: image,
            totalComments: 0,
            totalLikes: 0,
            username: widget.currentUser.username,
            userProfileUrl: widget.currentUser.profileUrl
        )
    ).then((value) => _clear());
  }

  _clear() {
    setState(() {
      _uploading = false;
      _descriptionController.clear();
      _image = null;
    });
  }

  _uploadPostWidget() {
    return Scaffold(
        backgroundColor: white,

        body: Center(
          child: GestureDetector(
            onTap: selectImage,
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
        )
    );
  }
}