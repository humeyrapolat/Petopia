import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:petopia/features/domain/entities/post/post_entity.dart';
import 'package:petopia/features/domain/entities/animal/animal_entity.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/user/get_current_uid_usecase.dart';
import 'package:petopia/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:petopia/features/presentation/cubit/post/post_cubit.dart';
import 'package:petopia/features/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:petopia/features/presentation/page/profile/liked/liked_post.dart';
import 'package:petopia/features/presentation/page/profile/post_type/hidden_post.dart';
import 'package:petopia/features/presentation/page/profile/post_type/shared_post.dart';
import 'package:petopia/util/consts.dart';
import 'package:petopia/injection_container.dart' as di;

import '../../../cubit/user/get_single_other_user/get_single_other_user_cubit.dart';
import '../../../cubit/user/user_cubit.dart';
import '../../../widgets/button_container_widget.dart';

class SingleUserProfileMainWigdet extends StatefulWidget {
  final String otherUserId;

  const SingleUserProfileMainWigdet({super.key, required this.otherUserId});

  @override
  State<SingleUserProfileMainWigdet> createState() =>
      _SingleUserProfileMainWigdetState();
}

class _SingleUserProfileMainWigdetState
    extends State<SingleUserProfileMainWigdet> {
  String _currentUid = "";

  @override
  void initState() {
    di.sl<GetCurrentUidUseCase>().call().then((value) {
      setState(() {
        _currentUid = value;
      });
    });
    BlocProvider.of<GetSingleOtherUserCubit>(context)
        .getSingleOtherUser(otherUid: widget.otherUserId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: BlocBuilder<GetSingleOtherUserCubit, GetSingleOtherUserState>(
        builder: (context, userState) {
          if (userState is GetSingleOtherUserLoaded) {
            final singleUser = userState.otherUser;
            return Scaffold(
              backgroundColor: white,
              appBar: AppBar(
                backgroundColor: darkBlueGreenColor,
                elevation: 0,
                title: Center(
                  child: Text(
                    "${singleUser.username}".toUpperCase(),
                    style: const TextStyle(color: black),
                  ),
                ),
                leading: const Icon(
                  Ionicons.ios_megaphone,
                ),
                actions: [
                  _currentUid == singleUser.uid
                      ? Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: InkWell(
                              onTap: () {
                                _openBottomModalSheet(
                                    context: context, currentUser: singleUser);
                              },
                              child: const Icon(
                                Icons.menu,
                                color: lightBlueGreenColor,
                              )),
                        )
                      : Container()
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
                        image: NetworkImage(singleUser.profileUrl! ??
                            "https://i.pinimg.com/474x/4b/2a/7f/4b2a7fd2bc5fcddd91a28d3421b418b2.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "@${singleUser.name}" ?? "username",
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
                                "${singleUser.totalPosts}",
                                style: const TextStyle(
                                    color: black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              sizeVertical(5),
                              const Text(
                                "Posts",
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
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, PageConsts.followersPage,
                                  arguments: singleUser);
                            },
                            child: Column(
                              children: [
                                Text(
                                  "${singleUser.totalFollowers}",
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
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, PageConsts.followingPage,
                                  arguments: singleUser);
                            },
                            child: Column(
                              children: [
                                Text(
                                  "${singleUser.totalFollowing}",
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
                      ),
                    ],
                  ),
                  sizeVertical(20),
                  Text(
                    singleUser.bio ?? "bio here",
                    style: const TextStyle(color: lightGrey, fontSize: 15),
                  ),
                  sizeVertical(10),
                  _currentUid == singleUser.uid
                      ? Container()
                      : ButtonContainerWidget(
                          text: singleUser.followers!.contains(_currentUid)
                              ? "UnFollow"
                              : "Follow",
                          color: singleUser.followers!.contains(_currentUid)
                              ? black.withOpacity(.4)
                              : darkBlueColor,
                          onTapListener: () {
                            BlocProvider.of<UserCubit>(context)
                                .followUnFollowUser(
                                    user: UserEntity(
                                        uid: _currentUid,
                                        otherUid: widget.otherUserId));
                          },
                        ),
                  singleUser.uid == _currentUid
                      ? const TabBar(
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
                        )
                      : const Icon(
                          Ionicons.ios_menu,
                          color: darkGrey,
                        ),
                  Expanded(
                      child: TabBarView(
                    children: [
                      SharedPostPage(currentUser: singleUser),
                      HiddenPostPage(
                        currentUser: singleUser,
                      ),
                      LikedPostPage(
                        currentUser: singleUser,
                      ),
                    ],
                  ))
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  _openBottomModalSheet(
      {required BuildContext context, required AnimalEntity currentUser}) {
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
