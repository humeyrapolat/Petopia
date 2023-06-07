import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petopia/features/domain/entities/post/post_entity.dart';
import 'package:petopia/features/domain/entities/animal/animal_entity.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/user/get_current_uid_usecase.dart';
import 'package:petopia/features/presentation/cubit/post/post_cubit.dart';
import 'package:petopia/features/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:petopia/profile_widget.dart';
import 'package:petopia/util/consts.dart';
import 'package:petopia/injection_container.dart' as di;

class HiddenPostMainWidget extends StatefulWidget {
  final AnimalEntity currentUser;

  const HiddenPostMainWidget({super.key, required this.currentUser});

  @override
  State<HiddenPostMainWidget> createState() => _HiddenPostMainWidgetState();
}

class _HiddenPostMainWidgetState extends State<HiddenPostMainWidget> {
  @override
  void initState() {
    print("current user : ${widget.currentUser}");

    BlocProvider.of<PostCubit>(context).getPosts(post: PostEntity());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, postState) {
        if (postState is PostLoaded) {
          final posts = postState.posts
              .where((post) =>
                  post.creatorUid == widget.currentUser.uid &&
                  post.isPrivate != false)
              .toList();
          return GridView.builder(
              itemCount: posts.length,
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 5, mainAxisSpacing: 5),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, PageConsts.postDetailPage,
                        arguments: posts[index].postId);
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    child: profileWidget(imageUrl: posts[index].postImageUrl),
                  ),
                );
              });
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
