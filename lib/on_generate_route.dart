import 'package:flutter/material.dart';
import 'package:petopia/features/domain/entities/user/user_entity.dart';
import 'package:petopia/features/presentation/page/announcement/emergency_call.dart';
import 'package:petopia/features/presentation/page/announcement/lost_animal.dart';
import 'package:petopia/features/presentation/page/credential/deneme.dart';
import 'package:petopia/features/presentation/page/credential/sign_in.dart';
import 'package:petopia/features/presentation/page/credential/sign_up_page.dart';
import 'package:petopia/features/presentation/page/home_page/chat/chat.dart';
import 'package:petopia/features/presentation/page/home_page/home_page.dart';
import 'package:petopia/features/presentation/page/home_page/post/comments/comments.dart';
import 'package:petopia/features/presentation/page/home_page/post/update_post_page.dart';
import 'package:petopia/features/presentation/page/home_page/search/search.dart';
import 'package:petopia/features/presentation/page/match/match.dart';
import 'package:petopia/features/presentation/page/profile/activity/acitivity.dart';
import 'package:petopia/features/presentation/page/profile/edit_profile/edit_profile.dart';
import 'package:petopia/features/presentation/page/profile/profile.dart';
import 'package:petopia/util/consts.dart';

import 'features/presentation/page/announcement/adoption.dart';

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
      case PageConsts.denemePage:
        {
          return routeBuilder(
            const MyHomePage(),
          );
        }
      case PageConsts.emergencyCallPage:
        {
          return routeBuilder(
            const EmergencyCallPage(),
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

      case PageConsts.updatePostPage:
        {
          return routeBuilder(
            const UpdatePostPage(),
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
          if (args is UserEntity) {
            return routeBuilder(
              ProfilePage(currentUser: args),
            );
          } else {
            return routeBuilder(
              const NoPageFound(),
            );
          }
        }
      case PageConsts.activityPage:
        {
          return routeBuilder(
            const ActivityPage(),
          );
        }
      case PageConsts.editProfilePage:
        {
          if (args is UserEntity) {
            return routeBuilder(EditProfilePage(
              currentUser: args,
            ));
          } else {
            return routeBuilder(NoPageFound());
          }
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
