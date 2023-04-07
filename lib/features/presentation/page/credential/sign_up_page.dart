import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petopia/features/domain/entities/user/user_entity.dart';
import 'package:petopia/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:petopia/features/presentation/cubit/credential/credential_cubit.dart';
import 'package:petopia/features/presentation/page/main_screen/main_screen.dart';
import 'package:petopia/profile_widget.dart';

import '../../../../util/consts.dart';
import '../../widgets/button_container_widget.dart';
import '../../widgets/form_container_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  bool _isSigningUp = false;
  bool _isUploading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    super.dispose();
  }
  File? _image;

  Future selectImage() async {
    try{
      final pickedFile = await ImagePicker.platform.getImage(source: ImageSource.gallery);
      setState(() {
        if(pickedFile != null) {
          _image = File(pickedFile.path);
        }else{
          print("no image has been selected");
        }
      });
    }catch(e){
      toast("some error occured $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      body: BlocConsumer<CredentialCubit, CredentialState>(
        listener: (context, credentialState) {
          if (credentialState is CredentialSuccess) {
            BlocProvider.of<AuthCubit>(context).loggedIn();
          }
          if (credentialState is CredentialFailure) {
            toast("Invalid Email and Password");
          }
        },
        builder: (context, credentialState) {
          if (credentialState is CredentialSuccess) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return MainScreen(
                    uid: authState.uid,
                  );
                } else {
                  return _bodyWidget();
                }
              },
            );
          }
          return _bodyWidget();
        },
      ),
    );
  }

  _bodyWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 2,
            child: Container(),
          ),
          // Center(
          //   child: Image.asset("assets/profile_default.png"),

          // ),
          const SizedBox(height: 15),
          Expanded(
            child: Center(
              child: Stack(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(30)),
                      child: ClipRRect(borderRadius: BorderRadius.circular(30),child: profileWidget(image: _image))

                  ),
                  Positioned(
                    right: -10,
                    bottom: -15,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(
                        Icons.add_a_photo,
                        color: black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          FormContainerWidget(
            controller: _usernameController,
            hintText: "Username",
          ),
          const SizedBox(height: 15),
          FormContainerWidget(
            controller: _emailController,
            hintText: "Email",
          ),
          const SizedBox(height: 15),
          FormContainerWidget(
            controller: _passwordController,
            hintText: "Password",
            isPasswordField: true,
          ),
          const SizedBox(height: 15),
          FormContainerWidget(
            controller: _bioController,
            hintText: "Bio",
          ),
          const SizedBox(height: 15),
          ButtonContainerWidget(
            color: darkBlueColor,
            text: "Sign Up",
            onTapListener: () {
              _signUpUser();
            },
          ),
          sizeVertical(10),
          _isSigningUp == true || _isUploading == true ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Please wait",
                      style: TextStyle(
                          color: black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    sizeHorizontal(10),
                    const CircularProgressIndicator()
                  ],
                )
              : Container(
                  width: 0,
                  height: 0,
                ),
          Flexible(
            flex: 2,
            child: Container(),
          ),
          const Divider(
            color: darkBlueColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Already have an account? ",
                style: TextStyle(color: black),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, PageConsts.signInPage, (route) => false);
                },
                child: const Text(
                  "Sign In.",
                  style: TextStyle(fontWeight: FontWeight.bold, color: black),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> _signUpUser() async {
    setState(() {
      _isSigningUp = true;
    });
    BlocProvider.of<CredentialCubit>(context)
        .signUpUser(
          UserEntity(
            email: _emailController.text,
            password: _passwordController.text,
            bio: _bioController.text,
            username: _usernameController.text,
            totalPosts: 0,
            totalFollowing: 0,
            followers: [],
            totalFollowers: 0,
            website: "",
            following: [],
            name: "",
            imageFile: _image,
          ),
        )
        .then((value) => _clearControllers());
  }

  _clearControllers() {
    setState(() {
      _usernameController.clear();
      _emailController.clear();
      _passwordController.clear();
      _bioController.clear();
      _isSigningUp = false;
    });
  }
}
