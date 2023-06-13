import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const white = Colors.white;
const black = Colors.black;
const darkGrey = Color.fromARGB(255, 49, 49, 49);
const lightGrey = Color.fromARGB(255, 155, 155, 155);

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

const lightPinkColor = Color.fromARGB(255, 252, 237, 239);
const darkPinkColor = Color(0xffe08594);

const darkPurpleColor = Color(0xFFB39DDB);
const lightPurpleColor = Color(0xFFEDE4F6);

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
  static const String resetPasswordPage = "resetPasswordPage";

  //announcement
  static const String adoptionPage = "adoptionPage";
  static const String emergencyCallPage = "emergencyCallPage";
  static const String lostAnimalPage = "lostAnimalPage";

  //home page
  static const String chatPage = "chatPage";
  static const String postPage = "postPage";
  static const String postDetailPage = "postDetailPage";
  static const String singleUserProfilePage = "singleUserProfilePage";
  static const String updatePostPage = "updatePostPage";
  static const String searchPage = "searchPage";
  static const String homePage = "homePage";
  static const String commentPage = "commentPage";
  static const String updateCommentPage = "updateCommentPage";
  static const String updateReplayPage = "updateReplayPage";

  //match
  static const String matchPage = "matchPage";
  static const String matchedPage = "matchedPage";

  //profile
  static const String profilePage = "profilePage";
  static const String activityPage = "activityPage";
  static const String editProfilePage = "editProfilePage";
  static const String hiddenPostPage = "hiddenPostPage";
  static const String sharedPostPage = "sharedPostPage";
  static const String likedPostPage = "likedPostPage";
  static const String followingPage = "followingPage";
  static const String followersPage = "followersPage";

  //no page
  static const String noPageFound = "noPageFound";
}

class FirebaseConsts {
  static const String users = "users";
  static const String post = "post";
  static const String comments = "comments";
  static const String likes = "likes";
  static const String followers = "followers";
  static const String favorites = "favorites";
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
    backgroundColor: darkPinkColor,
    textColor: black,
    fontSize: 16.0,
  );
}
