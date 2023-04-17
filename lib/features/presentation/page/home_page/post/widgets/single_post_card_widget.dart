import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';

import 'package:intl/intl.dart';
import 'package:petopia/injection_container.dart' as di;
import 'package:petopia/util/consts.dart';

import '../../../../../../profile_widget.dart';
import '../../../../../domain/entities/post/post_entity.dart';
import '../../../../../domain/usecases/firebase_usecases/user/get_current_uid_usecase.dart';
import '../../../../cubit/post/post_cubit.dart';


class SinglePostCardWidget extends StatefulWidget {
  final PostEntity post;

  const SinglePostCardWidget({Key? key, required this.post}) : super(key: key);

  @override
  State<SinglePostCardWidget> createState() => _SinglePostCardWidgetState();
}

class _SinglePostCardWidgetState extends State<SinglePostCardWidget> {
  String _currentUid = "";

  @override
  void initState() {
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: profileWidget(
                          imageUrl: "${widget.post.userProfileUrl}"),
                    ),
                  ),
                  sizeHorizontal(10),
                  Text(
                    "${widget.post.username}",
                    style: TextStyle(
                        color: black, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              GestureDetector(
                  onTap: () {
                    _openBottomModalSheet(context, widget.post);
                  },
                  child: Icon(
                    Icons.more_vert,
                    color: black,
                  ))
            ],
          ),
          sizeVertical(10),
          GestureDetector(
            onTap: () {
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
                  child: profileWidget(imageUrl: "${widget.post.postImageUrl}"),
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
                  Icon(
                    widget.post.likes!.contains(_currentUid)
                        ? Icons.favorite
                        : Icons.favorite_outline,
                    color: widget.post.likes!.contains(_currentUid)
                        ? Colors.red
                        : black,
                  ),
                  sizeHorizontal(10),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, PageConsts.commentPage);
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage()));
                      },
                      child: Icon(
                        Feather.message_circle,
                        color: black,
                      )),
                  sizeHorizontal(10),
                  Icon(
                    Feather.send,
                    color: black,
                  ),
                ],
              ),
              Icon(
                Icons.bookmark_border,
                color: black,
              )
            ],
          ),
          sizeVertical(10),
          Text(
            "${widget.post.totalLikes} likes",
            style: TextStyle(color: black, fontWeight: FontWeight.bold),
          ),
          sizeVertical(10),
          Row(
            children: [
              Text(
                "${widget.post.username}",
                style:
                TextStyle(color: black, fontWeight: FontWeight.bold),
              ),
              sizeHorizontal(10),
              Text(
                "${widget.post.description}",
                style: TextStyle(color: black),
              ),
            ],
          ),
          sizeVertical(10),
          Text(
            "View all ${widget.post.totalComments} comments",
            style: TextStyle(color: black),
          ),
          sizeVertical(10),
          Text(
            "${DateFormat("dd/MMM/yyy").format(widget.post.createAt!.toDate())}",
            style: TextStyle(color: black),
          ),
        ],
      ),
    );
  }

  _openBottomModalSheet(BuildContext context, PostEntity post) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 150,
            decoration: BoxDecoration(color: white.withOpacity(.8)),
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        "More Options",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: black),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Divider(
                      thickness: 1,
                      color: black,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: GestureDetector(
                        onTap: _deletePost,
                        child: Text(
                          "Delete Post",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: black),
                        ),
                      ),
                    ),
                    sizeVertical(7),
                    Divider(
                      thickness: 1,
                      color: black,
                    ),
                    sizeVertical(7),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, PageConsts.updatePostPage,
                              arguments: post);

                          // Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePostPage()));
                        },
                        child: Text(
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
        .deletePost(post: PostEntity(postId: widget.post.postId));
  }

  _likePost() {
    BlocProvider.of<PostCubit>(context)
        .likePost(post: PostEntity(postId: widget.post.postId));
  }
}
