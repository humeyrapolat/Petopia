import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:petopia/features/domain/entities/user/user_entity.dart';
import 'package:petopia/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:petopia/profile_widget.dart';
import 'package:petopia/util/consts.dart';

class ProfilePage extends StatelessWidget {
  final UserEntity currentUser;

  const ProfilePage({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: darkBlueGreenColor,
          title: Text(
            "${currentUser.username}",
            style: const TextStyle(color: lightBlueGreenColor),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: InkWell(
                onTap: () {
                  // go notifications page
                },
                child: const Icon(
                  Ionicons.ios_megaphone,
                ),
              ),
            ),
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: profileWidget(imageUrl: currentUser.profileUrl),
                      ),
                    ),
                    sizeVertical(15),
                    Text(
                      "${currentUser.name == "" ? currentUser.username : currentUser.name}",
                      style: const TextStyle(
                          color: darkBlueGreenColor,
                          fontWeight: FontWeight.bold),
                    ),
                    sizeVertical(15),
                    Text(
                      "${currentUser.bio}",
                      style: const TextStyle(color: darkBlueGreenColor),
                    ),
                    sizeVertical(10),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                "${currentUser.totalPosts}",
                                style: const TextStyle(
                                    color: darkBlueGreenColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              sizeVertical(8),
                              const Text(
                                "Posts",
                                style: TextStyle(color: darkBlueGreenColor),
                              )
                            ],
                          ),
                          sizeHorizontal(25),
                          GestureDetector(
                            onTap: () {
                              // Navigator.pushNamed(context, PageConsts.f, arguments: widget.currentUser);
                            },
                            child: Column(
                              children: [
                                Text(
                                  "${currentUser.totalFollowers}",
                                  style: const TextStyle(
                                      color: darkBlueGreenColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                sizeVertical(8),
                                const Text(
                                  "Followers",
                                  style: TextStyle(color: darkBlueGreenColor),
                                )
                              ],
                            ),
                          ),
                          sizeHorizontal(25),
                          GestureDetector(
                            onTap: () {
                              // Navigator.pushNamed(context, PageConst.followingPage, arguments: widget.currentUser);
                            },
                            child: Column(
                              children: [
                                Text(
                                  "${currentUser.totalFollowing}",
                                  style: const TextStyle(
                                      color: darkBlueGreenColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                sizeVertical(8),
                                const Text(
                                  "Following",
                                  style: TextStyle(color: darkBlueGreenColor),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 1,
                  color: darkGreenColor,
                ),
                sizeVertical(5),
                Column(
                  children: [
                    GridView.builder(
                        itemCount: 32,
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 16.0,
                          crossAxisSpacing: 16.0,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              //  Navigator.pushNamed(context, PageConst.postDetailPage, arguments: posts[index].postId);
                            },
                            child: Container(
                              width: 20,
                              height: 20,
                              color: Colors.grey,
                            ),
                          );
                        }),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  _openBottomModalSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 150,
            decoration: BoxDecoration(color: white.withOpacity(.8)),
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
                            color: darkBlueGreenColor),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Divider(
                      thickness: 1,
                      color: darkGreenColor,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                                  context, PageConsts.editProfilePage,
                                  arguments: currentUser)
                              .whenComplete(() {
                            Navigator.pop(context);
                          });
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage()));
                        },
                        child: const Text(
                          "Edit Profile",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: darkBlueGreenColor),
                        ),
                      ),
                    ),
                    sizeVertical(7),
                    const Divider(
                      thickness: 1,
                      color: darkGreenColor,
                    ),
                    sizeVertical(7),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: InkWell(
                        onTap: () {
                          BlocProvider.of<AuthCubit>(context).loggedOut();
                          Navigator.pushNamedAndRemoveUntil(
                              context, PageConsts.signInPage, (route) => false);
                        },
                        child: const Text(
                          "Logout",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: darkBlueGreenColor),
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
}
