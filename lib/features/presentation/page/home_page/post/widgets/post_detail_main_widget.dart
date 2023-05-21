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
  const PostDetailMainWidget({Key? key, required this.postId})
      : super(key: key);

  @override
  State<PostDetailMainWidget> createState() => _PostDetailMainWidgetState();
}

class _PostDetailMainWidgetState extends State<PostDetailMainWidget> {
  String _currentUid = "";

  @override
  void initState() {
    BlocProvider.of<GetSinglePostCubit>(context)
        .getSinglePost(postId: widget.postId);

    di.sl<GetCurrentUidUseCase>().call().then((value) {
      setState(() {
        _currentUid = value;
      });
    });
    super.initState();
  }

  bool _isLikeAnimating = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkOrangeColor,
        title: const Text("Post Detail"),
      ),
      backgroundColor: white,
      body: BlocBuilder<GetSinglePostCubit, GetSinglePostState>(
        builder: (context, getSinglePostState) {
          if (getSinglePostState is GetSinglePostLoaded) {
            final singlePost = getSinglePostState.post;
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
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
                              child: profileWidget(
                                  imageUrl: "${singlePost.userProfileUrl}"),
                            ),
                          ),
                          sizeHorizontal(10),
                          Text(
                            "${singlePost.username}",
                            style: const TextStyle(
                                color: black, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      singlePost.creatorUid == _currentUid
                          ? GestureDetector(
                              onTap: () {
                                _openBottomModalSheet(context, singlePost);
                              },
                              child: const Icon(
                                Icons.more_vert,
                                color: black,
                              ))
                          : const SizedBox(
                              width: 0,
                              height: 0,
                            )
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
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.30,
                          child: profileWidget(
                              imageUrl: "${singlePost.postImageUrl}"),
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
                                color: Colors.white,
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
                              onTap: () {
                                _likePost();
                              },
                              child: Icon(
                                singlePost.likes!.contains(_currentUid)
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                color: singlePost.likes!.contains(_currentUid)
                                    ? Colors.red
                                    : black,
                              )),
                          sizeHorizontal(10),
                          GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, PageConsts.commentPage,
                                    arguments: AppEntity(
                                        uid: _currentUid,
                                        postId: singlePost.postId));
                                //Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage()));
                              },
                              child: const Icon(
                                Feather.message_circle,
                                color: black,
                              )),
                          sizeHorizontal(10),
                          const Icon(
                            Feather.send,
                            color: black,
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.bookmark_border,
                        color: black,
                      )
                    ],
                  ),
                  sizeVertical(10),
                  Text(
                    "${singlePost.totalLikes} likes",
                    style: const TextStyle(
                        color: black, fontWeight: FontWeight.bold),
                  ),
                  sizeVertical(10),
                  Row(
                    children: [
                      Text(
                        "${singlePost.username}",
                        style: const TextStyle(
                            color: black, fontWeight: FontWeight.bold),
                      ),
                      sizeHorizontal(10),
                      Text(
                        "${singlePost.description}",
                        style: const TextStyle(color: black),
                      ),
                    ],
                  ),
                  sizeVertical(10),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, PageConsts.commentPage,
                            arguments: AppEntity(
                                uid: _currentUid, postId: singlePost.postId));
                      },
                      child: Text(
                        "View all ${singlePost.totalComments} comments",
                        style: const TextStyle(color: black),
                      )),
                  sizeVertical(10),
                  Text(
                    DateFormat("dd/MMM/yyy")
                        .format(singlePost.createAt!.toDate()),
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

  _openBottomModalSheet(BuildContext context, PostEntity post) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 150,
            decoration: const BoxDecoration(color: white),
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
                            color: black),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Divider(
                      thickness: 1,
                      color: darkBlueColor,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: GestureDetector(
                        onTap: _deletePost,
                        child: const Text(
                          "Delete Post",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: black),
                        ),
                      ),
                    ),
                    sizeVertical(7),
                    const Divider(
                      thickness: 1,
                      color: darkBlueGreenColor,
                    ),
                    sizeVertical(7),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, PageConsts.updatePostPage,
                              arguments: post);

                          // Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePostPage()));
                        },
                        child: const Text(
                          "Update Post",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: black),
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

  _deletePost() {
    BlocProvider.of<PostCubit>(context)
        .deletePost(post: PostEntity(postId: widget.postId));
  }

  _likePost() {
    BlocProvider.of<PostCubit>(context)
        .likePost(post: PostEntity(postId: widget.postId));
  }
}
