import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petopia/features/domain/entities/user/user_entity.dart';
import 'package:petopia/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:petopia/util/consts.dart';

class ProfilePage extends StatelessWidget {
  final UserEntity currentUser;
  const ProfilePage({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: darkBlueColor,
        appBar: AppBar(
          backgroundColor: darkBlueColor,
          title: Text(
            '${currentUser.username}',
            style: const TextStyle(color: lightBlueColor),
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
                    color: lightBlueColor,
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
                      decoration: const BoxDecoration(
                          color: lightBlueColor, shape: BoxShape.circle),
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              '${currentUser.totalPosts}',
                              style: const TextStyle(
                                  color: lightBlueColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            sizeVertical(8),
                            const Text(
                              "Posts",
                              style: TextStyle(color: lightBlueColor),
                            )
                          ],
                        ),
                        sizeHorizontal(25),
                        Column(
                          children: [
                            Text(
                              '${currentUser.totalFollowers}',
                              style: const TextStyle(
                                  color: lightBlueColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            sizeVertical(8),
                            const Text(
                              "Followers",
                              style: TextStyle(color: lightBlueColor),
                            )
                          ],
                        ),
                        sizeHorizontal(25),
                        Column(
                          children: [
                            Text(
                              '${currentUser.totalFollowing}',
                              style: const TextStyle(
                                  color: lightBlueColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            sizeVertical(8),
                            const Text(
                              "Following",
                              style: TextStyle(color: lightBlueColor),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
                sizeVertical(10),
                Text(
                  '${currentUser.name == "" ? currentUser.username : currentUser.name}',
                  style: const TextStyle(
                      color: lightBlueColor, fontWeight: FontWeight.bold),
                ),
                sizeVertical(10),
                Text(
                  '${currentUser.bio}',
                  style: const TextStyle(color: lightBlueColor),
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
                      return Container(
                        width: 100,
                        height: 100,
                        color: lightBlueColor,
                      );
                    })
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
                            color: lightBlueColor),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Divider(
                      thickness: 1,
                      color: lightBlueColor,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, PageConsts.editProfilePage);

                          //  Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage()));
                        },
                        child: const Text(
                          "Edit Profile",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: lightBlueColor),
                        ),
                      ),
                    ),
                    sizeVertical(7),
                    const Divider(
                      thickness: 1,
                      color: lightBlueColor,
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
                              color: backGroundColor),
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
