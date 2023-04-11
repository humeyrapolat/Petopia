import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:petopia/features/domain/entities/user/user_entity.dart';
import 'package:petopia/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:petopia/features/presentation/page/profile/liked/liked_post.dart';
import 'package:petopia/features/presentation/page/profile/post_type/hidden_post.dart';
import 'package:petopia/features/presentation/page/profile/post_type/shared_post.dart';
import 'package:petopia/util/consts.dart';

class ProfilePage extends StatelessWidget {
  final UserEntity currentUser;

  const ProfilePage({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: darkBlueGreenColor,
          elevation: 0,
          title: Center(
            child: Text(
              "${currentUser.username}".toUpperCase(),
              style: const TextStyle(color: black),
            ),
          ),
          leading: const Icon(
            Ionicons.ios_megaphone,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: InkWell(
                  onTap: () {
                    _openBottomModalSheet(context);
                  },
                  child: const Icon(
                    Icons.menu,
                    color: lightBlueGreenColor,
                  )),
            )
          ],
        ),
        body: Column(
          children: [
            sizeVertical(25),
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(currentUser.profileUrl! ??
                      "https://i.pinimg.com/474x/4b/2a/7f/4b2a7fd2bc5fcddd91a28d3421b418b2.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "@${currentUser.name}" ?? "username",
                style: const TextStyle(color: black, fontSize: 15),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Column(
                      children: [
                        Text(
                          "${currentUser.totalPosts}",
                          style: const TextStyle(
                              color: black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        sizeVertical(5),
                        const Text(
                          "Followers",
                          style: TextStyle(
                              color: lightGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        Text(
                          "${currentUser.totalFollowers}",
                          style: const TextStyle(
                              color: black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        sizeVertical(5),
                        const Text(
                          "Followers",
                          style: TextStyle(
                              color: lightGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Text(
                          "${currentUser.totalFollowing}",
                          style: const TextStyle(
                              color: black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        sizeVertical(5),
                        const Text(
                          "Following",
                          style: TextStyle(
                              color: lightGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            sizeVertical(20),
            Text(
              currentUser.bio ?? "bio here",
              style: const TextStyle(color: lightGrey, fontSize: 15),
            ),
            const TabBar(
              tabs: [
                Tab(
                  icon: Icon(
                    Ionicons.ios_menu,
                    color: darkGrey,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.hide_image_outlined,
                    color: darkGrey,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.favorite_border_outlined,
                    color: darkGrey,
                  ),
                ),
              ],
              indicatorColor: lightGrey,
            ),
            const Expanded(
                child: TabBarView(
              children: [
                SharedPostPage(),
                HiddenPostPage(),
                LikedPostPage(),
              ],
            ))
          ],
        ),
      ),
    );
  }

  _openBottomModalSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              height: 150,
              decoration: BoxDecoration(
                color: white.withOpacity(.8),
              ),
              child: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Center(
                      child: Text(
                        "More options",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  sizeVertical(5),
                  const Divider(
                    color: darkGrey,
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.edit_outlined,
                            color: darkBlueGreenColor,
                            size: 25,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                                  context, PageConsts.editProfilePage,
                                  arguments: currentUser)
                              .whenComplete(() {
                            Navigator.pop(context);
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            "Edit Profile",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.logout_outlined,
                            color: darkBlueGreenColor,
                            size: 25,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<AuthCubit>(context).loggedOut();
                          Navigator.pushNamedAndRemoveUntil(
                              context, PageConsts.signInPage, (route) => false);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            "Logout",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ));
        });
  }
}
