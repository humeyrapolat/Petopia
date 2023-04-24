import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:petopia/features/presentation/page/home_page/post/widgets/single_post_card_widget.dart';
import 'package:petopia/injection_container.dart' as di;

import '../../../../util/consts.dart';
import '../../../domain/entities/post/post_entity.dart';
import '../../cubit/post/post_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: darkPinkColor,
        title: Text("PETOPIA"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, PageConsts.chatPage);
              },
              child: const Icon(
                MaterialCommunityIcons.facebook_messenger,
                color: lightPinkColor,
              ),
            ),
          )
        ],
      ),
      body: BlocProvider<PostCubit>(
        create: (context) => di.sl<PostCubit>()..getPosts(post: PostEntity()),
        child: BlocBuilder<PostCubit, PostState>(
          builder: (context, postState) {
            if (postState is PostLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (postState is PostFailure) {
              toast("Some Failure occured while creating the post");
            }
            if (postState is PostLoaded) {
              return postState.posts.isEmpty
                  ? _noPostsYetWidget()
                  : ListView.builder(
                      itemCount: postState.posts.length,
                      itemBuilder: (context, index) {
                        final post = postState.posts[index];
                        return BlocProvider(
                          create: (context) => di.sl<PostCubit>(),
                          child: SinglePagePostCardWidget(post: post),
                        );
                      },
                    );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  _noPostsYetWidget() {
    return Center(
      child: Text(
        "No Posts Yet",
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }
}
