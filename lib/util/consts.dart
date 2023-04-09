import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const backGroundColor = Colors.white;
const black = Colors.black;

const lightBlueGreenColor = Color(0xffddf1f0);
const darkBlueGreenColor = Color(0xff78c8bb);

const lightBlueColor = Color(0xffdbeefc);
const darkBlueColor = Color(0xff65c4f0);

const lightGreenColor = Color(0xffe1f0dd);
const darkGreenColor = Color(0xff83c271);

const lightYellowColor = Color(0xfffef2da);
const darkYellowColor = Color(0xfffed36d);

const lightOrangeColor = Color(0xffffded7);
const darkOrangeColor = Color(0xffff805d);

const lightPinkColor = Color(0xfff6e0e3);
const darkPinkColor = Color(0xffe08594);

Widget sizeVertical(double height) {
  return SizedBox(height: height);
}

Widget sizeHorizontal(double width) {
  return SizedBox(width: width);
}

class PageConsts {
  //credentials
  static const String signInPage = "signInPage";
  static const String signUpPage = "signUpPage";
  static const String denemePage = "denemePage";
  //announcement
  static const String adoptionPage = "adoptionPage";
  static const String emergencyCallPage = "emergencyCallPage";
  static const String lostAnimalPage = "lostAnimalPage";
  //home page
  static const String chatPage = "chatPage";
  static const String postPage = "postPage";
  static const String updatePostPage = "updatePostPage";
  static const String searchPage = "searchPage";
  static const String homePage = "homePage";
  static const String commentPage = "commentPage";

  //match
  static const String matchPage = "matchPage";
  //profile
  static const String profilePage = "profilePage";
  static const String activityPage = "activityPage";
  static const String editProfilePage = "editProfilePage";

  //no page
  static const String noPageFound = "noPageFound";
}

class FirebaseConsts {
  static const String users = "users";
  static const String post = "post";
  static const String comments = "comments";
  static const String likes = "likes";
  static const String followers = "followers";
  static const String following = "following";
  static const String feed = "feed";
  static const String replay = "replay";
  static const String feedItems = "feedItems";
  static const String activityFeed = "activityFeed";
}

void toast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: lightPinkColor,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
