import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:petopia/features/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:petopia/features/presentation/page/announcement/announcement.dart';
import 'package:petopia/features/presentation/page/home_page/home_page.dart';
import 'package:petopia/features/presentation/page/home_page/post/comments/comments_page.dart';
import 'package:petopia/features/presentation/page/profile/profile.dart';
import 'package:petopia/util/consts.dart';

class MainScreen extends StatefulWidget {
  final String uid;
  const MainScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  late PageController pageController;

  @override
  void initState() {
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.uid);
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void navigationTapped(int index) {
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
      builder: (context, getSingleUserState) {
        if (getSingleUserState is GetSingleUserLoaded) {
          final currentUser = getSingleUserState.user;
          return Scaffold(
              backgroundColor: black,
              bottomNavigationBar: CupertinoTabBar(
                backgroundColor: black,
                activeColor: Colors.white,
                inactiveColor: Colors.white,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(MaterialCommunityIcons.home_variant,
                          color: lightBlueGreenColor),
                      label: ""),
                  BottomNavigationBarItem(
                      icon: Icon(Ionicons.ios_megaphone,
                          color: lightBlueGreenColor),
                      label: ""),
                  BottomNavigationBarItem(
                      icon: Icon(Ionicons.ios_paw, color: lightBlueGreenColor),
                      label: ""),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.account_circle_outlined,
                          color: lightBlueGreenColor),
                      label: ""),
                ],
                onTap: navigationTapped,
              ),
              body: PageView(
                controller: pageController,
                onPageChanged: onPageChanged,
                children: [
                  const HomePage(),
                  Announcement(),
                  const CommentPage(),
                  ProfilePage(currentUser: currentUser),
                ],
              ));
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
