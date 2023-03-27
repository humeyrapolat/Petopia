import 'package:flutter/cupertino.dart';
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
        title: Text("PETAPP"),//SvgPicture.asset("assets/profile_default.png", color: primaryColor, height: 32,),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Icon(MaterialCommunityIcons.facebook_messenger, color: lightGreenColor,),
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
                      decoration: BoxDecoration(
                          color: lightGreenColor,
                          shape: BoxShape.circle
                      ),
                    ),
                    sizeHorizontal(10),
                    Text("Username", style: TextStyle(color: lightGreenColor, fontWeight: FontWeight.bold),)
                  ],
                ),
                GestureDetector(
                    onTap: () {
                      _openBottomModalSheet(context);
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePostPage()));
                    }
                    ,child: Icon(Icons.more_vert, color: lightGreenColor,))
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
                    Icon(Icons.favorite, color: lightGreenColor,),
                    sizeHorizontal(10),
                    GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, PageConsts.commentPage);

                          //Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage()));
                        }
                        ,child:Icon(Feather.message_circle, color: lightGreenColor,)),

                    sizeHorizontal(10),
                    Icon(Feather.send, color: lightGreenColor,),
                  ],
                ),
                Icon(Icons.bookmark_border, color: lightGreenColor,)

              ],
            ),
            sizeVertical(10),
            Row(
              children: [
                Text("Username", style: TextStyle(color: lightGreenColor, fontWeight: FontWeight.bold),),
                sizeHorizontal(10),
                Text("some description", style: TextStyle(color: lightGreenColor),),
              ],
            ),
            sizeVertical(10),
            Text("View all 10 comments", style: TextStyle(color: darkBlueColor),),
            sizeVertical(10),
            Text("08/5/2022", style: TextStyle(color: darkBlueColor),),

          ],
        ),
      ),
    );
  }
}
_openBottomModalSheet(BuildContext context) {
  return showModalBottomSheet(context: context, builder: (context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(color: backGroundColor.withOpacity(.8)),
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  "More Options",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: lightGreenColor),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Divider(
                thickness: 1,
                color: lightGreenColor,
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  "Delete Post",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: lightGreenColor),
                ),
              ),
              sizeVertical(7),
              Divider(
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
                  child: Text(
                    "Update Post",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: lightGreenColor),
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

