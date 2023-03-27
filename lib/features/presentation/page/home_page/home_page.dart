import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:petopia/util/consts.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueColor,
      appBar: AppBar(
        backgroundColor: darkPinkColor,
        title: const Text(
            "PETAPP"), //SvgPicture.asset("assets/profile_default.png", color: primaryColor, height: 32,),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(
              MaterialCommunityIcons.facebook_messenger,
              color: lightGreenColor,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                          color: lightGreenColor, shape: BoxShape.circle),
                    ),
                    sizeHorizontal(10),
                    const Text(
                      "Username",
                      style: TextStyle(
                          color: lightGreenColor, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                GestureDetector(
                    onTap: () {
                      _openBottomModalSheet(context);
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePostPage()));
                    },
                    child: const Icon(
                      Icons.more_vert,
                      color: lightGreenColor,
                    ))
              ],
            ),
            sizeVertical(10),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.30,
              color: lightGreenColor,
            ),
            sizeVertical(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.favorite,
                      color: lightGreenColor,
                    ),
                    sizeHorizontal(10),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, PageConsts.commentPage);

                          //Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage()));
                        },
                        child: const Icon(
                          Feather.message_circle,
                          color: lightGreenColor,
                        )),
                    sizeHorizontal(10),
                    const Icon(
                      Feather.send,
                      color: lightGreenColor,
                    ),
                  ],
                ),
                const Icon(
                  Icons.bookmark_border,
                  color: lightGreenColor,
                )
              ],
            ),
            sizeVertical(10),
            Row(
              children: [
                const Text(
                  "Username",
                  style: TextStyle(
                      color: lightGreenColor, fontWeight: FontWeight.bold),
                ),
                sizeHorizontal(10),
                const Text(
                  "some description",
                  style: TextStyle(color: lightGreenColor),
                ),
              ],
            ),
            sizeVertical(10),
            const Text(
              "View all 10 comments",
              style: TextStyle(color: darkBlueColor),
            ),
            sizeVertical(10),
            const Text(
              "08/5/2022",
              style: TextStyle(color: darkBlueColor),
            ),
          ],
        ),
      ),
    );
  }
}

_openBottomModalSheet(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 150,
          decoration: BoxDecoration(color: backGroundColor.withOpacity(.8)),
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "More Options",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: lightGreenColor),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Divider(
                    thickness: 1,
                    color: lightGreenColor,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Delete Post",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: lightGreenColor),
                    ),
                  ),
                  sizeVertical(7),
                  const Divider(
                    thickness: 1,
                    color: lightGreenColor,
                  ),
                  sizeVertical(7),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, PageConsts.updatePostPage);

                        //Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePostPage()));
                      },
                      child: const Text(
                        "Update Post",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: lightGreenColor),
                      ),
                    ),
                  ),
                  sizeVertical(7),
                ],
              ),
            ),
          ),
        );
      });
}
