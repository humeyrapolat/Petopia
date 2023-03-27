import 'package:flutter/material.dart';
import 'package:petopia/features/data/data_sources/adoption.dart';
import 'package:petopia/features/presentation/page/announcement/emergency_call.dart';
import 'package:petopia/features/presentation/page/announcement/lost_animal.dart';
import 'package:petopia/features/presentation/page/credential/sign_in.dart';
import 'package:petopia/features/presentation/page/credential/sign_up_page.dart';
import 'package:petopia/features/presentation/page/home_page/chat/chat.dart';
import 'package:petopia/features/presentation/page/home_page/home_page.dart';
import 'package:petopia/features/presentation/page/home_page/post/comments/comments.dart';
import 'package:petopia/features/presentation/page/home_page/post/post.dart';
import 'package:petopia/features/presentation/page/home_page/search/search.dart';
import 'package:petopia/features/presentation/page/match/match.dart';
import 'package:petopia/features/presentation/page/profile/activity/acitivity.dart';
import 'package:petopia/features/presentation/page/profile/edit_profile/edit_profile.dart';
import 'package:petopia/features/presentation/page/profile/profile.dart';
import 'package:petopia/util/consts.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case PageConsts.signInPage:
        {
          return routeBuilder(
            const SignInPage(),
          );
        }
      case PageConsts.signUpPage:
        {
          return routeBuilder(
            const SignUpPage(),
          );
        }
      case PageConsts.adoptionPage:
        {
          return routeBuilder(
            const AdoptionPage(),
          );
        }
      case PageConsts.emergencyCallPage:
        {
          return routeBuilder(
            const EmergencyCall(),
          );
        }

      case PageConsts.lostAnimalPage:
        {
          return routeBuilder(
            const LostAnimalPage(),
          );
        }
      case PageConsts.chatPage:
        {
          return routeBuilder(
            const ChatPage(),
          );
        }
      case PageConsts.postPage:
        {
          return routeBuilder(
            const PostPage(),
          );
        }
      case PageConsts.searchPage:
        {
          return routeBuilder(
            const SearchPage(),
          );
        }

      case PageConsts.homePage:
        {
          return routeBuilder(
            const HomePage(),
          );
        }

      case PageConsts.commentPage:
        {
          return routeBuilder(
            const CommentPage(),
          );
        }
      case PageConsts.matchPage:
        {
          return routeBuilder(
            const MatchPage(),
          );
        }

      case PageConsts.profilePage:
        {
          return routeBuilder(
            const Profile(),
          );
        }
      case PageConsts.activityPage:
        {
          return routeBuilder(
            const ActivityPage(),
          );
        }
      case PageConsts.editProfilePage:
        {
          return routeBuilder(
            const EditProfilePage(),
          );
        }

      default:
        {
          const NoPageFound();
        }
    }
  }
}

class NoPageFound extends StatelessWidget {
  const NoPageFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("No Page Found"),
      ),
      body: const Center(
        child: Text("No Page Found"),
      ),
    );
  }
}

dynamic routeBuilder(Widget child) {
  return MaterialPageRoute(
    builder: (context) => child,
  );
}
