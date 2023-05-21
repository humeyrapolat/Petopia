import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petopia/features/domain/entities/post/post_entity.dart';
import 'package:petopia/features/presentation/cubit/post/post_cubit.dart';
import 'package:petopia/profile_widget.dart';
import 'package:petopia/util/consts.dart';

import 'search_widget.dart';

class SearchMainWidget extends StatefulWidget {
  const SearchMainWidget({Key? key}) : super(key: key);

  @override
  State<SearchMainWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchMainWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<PostCubit>(context).getPosts(post: PostEntity());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchWidget(
                  controller: _searchController,
                ),
                sizeVertical(10),
                BlocBuilder<PostCubit, PostState>(
                  builder: (context, postState) {
                    if (postState is PostLoaded) {
                      final posts = postState.posts;
                      return GridView.builder(
                          itemCount: posts.length,
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
                                Navigator.pushNamed(
                                    context, PageConsts.postDetailPage,
                                    arguments: posts[index].postId);
                              },
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: profileWidget(
                                  imageUrl: posts[index].postImageUrl,
                                ),
                              ),
                            );
                          });
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
