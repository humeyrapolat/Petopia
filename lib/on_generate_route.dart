import 'package:flutter/material.dart';
import 'package:petopia/features/domain/entities/app_entity.dart';
import 'package:petopia/features/domain/entities/animal/animal_entity.dart';
import 'package:petopia/features/presentation/page/announcement/emergency_call.dart';
import 'package:petopia/features/presentation/page/announcement/lost_animal.dart';
import 'package:petopia/features/presentation/page/credential/reset_password.dart';
import 'package:petopia/features/presentation/page/credential/sign_in.dart';
import 'package:petopia/features/presentation/page/credential/sign_up_page.dart';
import 'package:petopia/features/presentation/page/home_page/chat/chat.dart';
import 'package:petopia/features/presentation/page/home_page/home_page.dart';
import 'package:petopia/features/presentation/page/home_page/post/comments/comments_page.dart';
import 'package:petopia/features/presentation/page/home_page/post/post_detail_page.dart';
import 'package:petopia/features/presentation/page/home_page/post/update_post_page.dart';
import 'package:petopia/features/presentation/page/home_page/search/search.dart';
import 'package:petopia/features/presentation/page/match/match.dart';
import 'package:petopia/features/presentation/page/profile/activity/acitivity.dart';
import 'package:petopia/features/presentation/page/profile/edit_profile/edit_profile.dart';
import 'package:petopia/features/presentation/page/profile/liked/liked_post.dart';
import 'package:petopia/features/presentation/page/profile/post_type/hidden_post.dart';
import 'package:petopia/features/presentation/page/profile/post_type/shared_post.dart';
import 'package:petopia/features/presentation/page/profile/profile.dart';
import 'package:petopia/features/presentation/page/profile/single_user_profile_page.dart';
import 'package:petopia/util/consts.dart';

import 'features/domain/entities/comment/comment_entity.dart';
import 'features/domain/entities/post/post_entity.dart';
import 'features/domain/entities/replay/replay_entity.dart';
import 'features/presentation/page/announcement/adoption.dart';
import 'features/presentation/page/home_page/post/comments/edit_comment_page.dart';
import 'features/presentation/page/home_page/post/comments/edit_replay_page.dart';
import 'features/presentation/page/profile/followers_page.dart';
import 'features/presentation/page/profile/following_page.dart';

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
            ChatPage(),
          );
        }
      case PageConsts.resetPasswordPage:
        {
          return routeBuilder(
            const ResetPasswordPage(),
          );
        }

      case PageConsts.updatePostPage:
        {
          if (args is PostEntity) {
            return routeBuilder(UpdatePostPage(
              post: args,
            ));
          } else {
            return routeBuilder(const NoPageFound());
          }
        }
      case PageConsts.postDetailPage:
        {
          if (args is String) {
            return routeBuilder(PostDetailPage(
              postId: args,
            ));
          } else {
            return routeBuilder(const NoPageFound());
          }
        }
      case PageConsts.followingPage:
        {
          if (args is AnimalEntity) {
            return routeBuilder(FollowingPage(
              user: args,
            ));
          }
          return routeBuilder(const NoPageFound());
        }
      case PageConsts.followersPage:
        {
          if (args is AnimalEntity) {
            return routeBuilder(FollowersPage(
              user: args,
            ));
          }
          return routeBuilder(const NoPageFound());
        }
      case PageConsts.singleUserProfilePage:
        {
          if (args is String) {
            return routeBuilder(SingleUserProfilePage(
              otherUserId: args,
            ));
          } else {
            return routeBuilder(const NoPageFound());
          }
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
          if (args is AppEntity) {
            return routeBuilder(
              CommentPage(
                appEntity: args,
              ),
            );
          }
          return routeBuilder(
            const NoPageFound(),
          );
        }
      case PageConsts.updateCommentPage:
        {
          if (args is CommentEntity) {
            return routeBuilder(EditCommentPage(
              comment: args,
            ));
          } else {
            return routeBuilder(const NoPageFound());
          }
        }
      case PageConsts.updateReplayPage:
        {
          if (args is ReplayEntity) {
            return routeBuilder(EditReplayPage(
              replay: args,
            ));
          } else {
            return routeBuilder(const NoPageFound());
          }
        }
      case PageConsts.matchPage:
        {
          return routeBuilder(
            const MatchPage(),
          );
        }

      case PageConsts.profilePage:
        {
          if (args is AnimalEntity) {
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
          if (args is AnimalEntity) {
            return routeBuilder(EditProfilePage(
              currentUser: args,
            ));
          } else {
            return routeBuilder(const NoPageFound());
          }
        }
      case PageConsts.hiddenPostPage:
        {
          if (args is AnimalEntity) {
            return routeBuilder(HiddenPostPage(
              currentUser: args,
            ));
          } else {
            return routeBuilder(const NoPageFound());
          }
        }
      case PageConsts.sharedPostPage:
        {
          if (args is AnimalEntity) {
            return routeBuilder(SharedPostPage(
              currentUser: args,
            ));
          } else {
            return routeBuilder(const NoPageFound());
          }
        }
      case PageConsts.likedPostPage:
        {
          if (args is AnimalEntity) {
            return routeBuilder(LikedPostPage(
              currentUser: args,
            ));
          } else {
            return routeBuilder(const NoPageFound());
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
