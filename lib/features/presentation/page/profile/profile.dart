import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        backgroundColor: backGroundColor,
        appBar: AppBar(
          backgroundColor: backGroundColor,
          title: Text(
            "${currentUser.username}",
            style: const TextStyle(color: darkOrangeColor),
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
                    color: darkOrangeColor,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: profileWidget(imageUrl: currentUser.profileUrl),
                      ),
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              "${currentUser.totalPosts}",
                              style: const TextStyle(
                                  color: darkOrangeColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            sizeVertical(8),
                            const Text(
                              "Posts",
                              style: TextStyle(color: darkOrangeColor),
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
                                    color: darkOrangeColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              sizeVertical(8),
                              const Text(
                                "Followers",
                                style: TextStyle(color: darkOrangeColor),
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
                                    color: darkOrangeColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              sizeVertical(8),
                              const Text(
                                "Following",
                                style: TextStyle(color: darkOrangeColor),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
                sizeVertical(10),
                Text(
                  "${currentUser.name == "" ? currentUser.username : currentUser.name}",
                  style: const TextStyle(
                      color: darkOrangeColor, fontWeight: FontWeight.bold),
                ),
                sizeVertical(10),
                Text(
                  "${currentUser.bio}",
                  style: const TextStyle(color: darkOrangeColor),
                ),
                sizeVertical(10),
                GridView.builder(
                    itemCount: 32,
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          //  Navigator.pushNamed(context, PageConst.postDetailPage, arguments: posts[index].postId);
                        },
                        child: Container(
                          width: 20,
                          height: 20,
                          color: Colors.red,
                        ),
                      );
                    }),
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
                            color: darkOrangeColor),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Divider(
                      thickness: 1,
                      color: darkOrangeColor,
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
                              arguments: currentUser);
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage()));
                        },
                        child: const Text(
                          "Edit Profile",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: darkOrangeColor),
                        ),
                      ),
                    ),
                    sizeVertical(7),
                    const Divider(
                      thickness: 1,
                      color: darkOrangeColor,
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
                              color: darkOrangeColor),
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
