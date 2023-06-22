import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:intl/intl.dart';
import 'package:petopia/features/domain/entities/app_entity.dart';
import 'package:petopia/features/domain/entities/post/post_entity.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/user/get_current_uid_usecase.dart';
import 'package:petopia/features/presentation/cubit/post/get_single_post/get_single_post_cubit.dart';
import 'package:petopia/features/presentation/cubit/post/post_cubit.dart';
import 'package:petopia/features/presentation/page/home_page/post/widgets/like_animation_widget.dart';
import 'package:petopia/profile_widget.dart';
import 'package:petopia/util/consts.dart';
import 'package:petopia/injection_container.dart' as di;

class PostDetailMainWidget extends StatefulWidget {
  final String postId;
  const PostDetailMainWidget({super.key, required this.postId});

  @override
  State<PostDetailMainWidget> createState() => _PostDetailMainWidgetState();
}

class _PostDetailMainWidgetState extends State<PostDetailMainWidget> {
  bool _isLikeAnimating = false;
  String _currentUid = " ";

  @override
  void initState() {
    BlocProvider.of<GetSinglePostCubit>(context).getSinglePost(postId: widget.postId);

    di.sl<GetCurrentUidUseCase>().call().then((value) {
      setState(() {
        _currentUid = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: darkPurpleColor,
        title: const Text("Post Detail"),
      ),
      body: BlocBuilder<GetSinglePostCubit, GetSinglePostState>(
        builder: (context, getSinglePostState) {
          if (getSinglePostState is GetSinglePostLoaded) {
            final getSinglePost = getSinglePostState.post;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: profileWidget(imageUrl: "${getSinglePost.userProfileUrl}"),
                            ),
                          ),
                          sizeHorizontal(10),
                          Text(
                            getSinglePost.username!,
                            style: const TextStyle(color: black, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      getSinglePost.creatorUid == _currentUid
                          ? GestureDetector(
                              onTap: () {
                                _openModalBottomSheet(context, getSinglePost);
                              },
                              child: const Icon(Icons.more_vert, color: darkGrey),
                            )
                          : Container(),
                    ],
                  ),
                  sizeVertical(10),
                  GestureDetector(
                    onDoubleTap: () {
                      _likePost();
                      setState(() {
                        _isLikeAnimating = true;
                      });
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.30,
                          child: profileWidget(imageUrl: "${getSinglePost.postImageUrl}"),
                        ),
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: _isLikeAnimating ? 1 : 0,
                          child: LikeAnimationWidget(
                              duration: const Duration(milliseconds: 200),
                              isLikeAnimating: _isLikeAnimating,
                              onLikeFinish: () {
                                setState(() {
                                  _isLikeAnimating = false;
                                });
                              },
                              child: const Icon(
                                Icons.favorite,
                                size: 100,
                                color: darkGrey,
                              )),
                        ),
                      ],
                    ),
                  ),
                  sizeVertical(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: _likePost,
                            child: Icon(
                              getSinglePost.likes!.contains(_currentUid) ? Icons.favorite : Icons.favorite_outline,
                              color: getSinglePost.likes!.contains(_currentUid) ? Colors.red : darkGrey,
                            ),
                          ),
                          sizeHorizontal(10),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, PageConsts.commentPage,
                                  arguments: AppEntity(
                                    uid: _currentUid,
                                    postId: getSinglePost.postId,
                                  ));
                            },
                            child: const Icon(
                              Feather.message_circle,
                              color: darkGrey,
                            ),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.bookmark_border,
                        color: white,
                      ),
                    ],
                  ),
                  sizeVertical(10),
                  Text(
                    "${getSinglePost.totalLikes} likes",
                    style: const TextStyle(color: black, fontWeight: FontWeight.bold),
                  ),
                  sizeVertical(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${getSinglePost.username}",
                        style: const TextStyle(color: black, fontWeight: FontWeight.bold),
                      ),
                      sizeHorizontal(10),
                      Text(
                        "${getSinglePost.description}",
                        style: const TextStyle(color: black),
                      ),
                    ],
                  ),
                  sizeVertical(10),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, PageConsts.commentPage,
                          arguments: AppEntity(
                            uid: _currentUid,
                            postId: getSinglePost.postId,
                          ));
                    },
                    child: Text(
                      getSinglePost.totalComments == 0
                          ? "No Comments"
                          : "View all ${getSinglePost.totalComments} comments",
                      style: const TextStyle(color: black),
                    ),
                  ),
                  sizeVertical(10),
                  Text(
                    DateFormat('dd MMM yyyy').format(getSinglePost.createAt!.toDate()),
                    style: const TextStyle(color: black),
                  ),
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

  _openModalBottomSheet(BuildContext context, PostEntity post) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: lightPurpleColor,
            height: 150,
            child: SingleChildScrollView(
              child: Container(
                color: lightPurpleColor,
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "More Options",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: black),
                    ),
                  ),
                  sizeVertical(10),
                  const Divider(
                    thickness: 1,
                    color: black,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: GestureDetector(
                      onTap: () {
                        _deletePost();
                      },
                      child: const Text(
                        "Delete Post ",
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: black),
                      ),
                    ),
                  ),
                  sizeVertical(7),
                  const Divider(
                    thickness: 1,
                    color: black,
                  ),
                  sizeVertical(7),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, PageConsts.updatePostPage, arguments: post);
                      },
                      child: const Text(
                        "Update Post ",
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  sizeVertical(7),
                  const Divider(
                    thickness: 1,
                    color: black,
                  ),
                  sizeVertical(7),
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Logout",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: white),
                    ),
                  )
                ]),
              ),
            ),
          );
        });
  }

  _deletePost() {
    BlocProvider.of<PostCubit>(context).deletePost(post: PostEntity(postId: widget.postId));
  }

  _likePost() {
    BlocProvider.of<PostCubit>(context).likePost(post: PostEntity(postId: widget.postId));
  }
}
