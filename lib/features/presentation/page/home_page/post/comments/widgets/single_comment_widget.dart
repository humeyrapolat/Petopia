import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:petopia/features/domain/entities/comment/comment_entity.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/user/get_current_uid_usecase.dart';
import 'package:petopia/features/presentation/page/home_page/post/comments/widgets/single_replay_widget.dart';
import 'package:petopia/features/presentation/widgets/form_container_widget.dart';
import 'package:petopia/injection_container.dart' as di;
import 'package:petopia/profile_widget.dart';
import 'package:petopia/util/consts.dart';
import 'package:uuid/uuid.dart';

import '../../../../../../domain/entities/replay/replay_entity.dart';
import '../../../../../../domain/entities/animal/animal_entity.dart';
import '../../../../../cubit/replay/replay_cubit.dart';

class SingleCommentWidget extends StatefulWidget {
  final CommentEntity comment;
  final VoidCallback? onLongPressListener;
  final VoidCallback? onLikePressListener;
  final AnimalEntity? currentUser;
  const SingleCommentWidget(
      {Key? key,
      required this.comment,
      this.onLongPressListener,
      this.onLikePressListener,
      this.currentUser})
      : super(key: key);

  @override
  State<SingleCommentWidget> createState() => _SingleCommentWidgetState();
}

class _SingleCommentWidgetState extends State<SingleCommentWidget> {
  TextEditingController _replayDescriptionController = TextEditingController();
  String _currentUid = "";

  @override
  void initState() {
    di.sl<GetCurrentUidUseCase>().call().then((value) {
      setState(() {
        _currentUid = value;
      });
    });

    BlocProvider.of<ReplayCubit>(context).getReplays(
        replay: ReplayEntity(
            postId: widget.comment.postId,
            commentId: widget.comment.commentId));

    super.initState();
  }

  bool _isUserReplaying = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: widget.comment.creatorUid == _currentUid
          ? widget.onLongPressListener
          : null,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: profileWidget(
                  imageUrl: widget.comment.userProfileUrl!,
                ),
              ),
            ),
            sizeHorizontal(10),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${widget.comment.username}",
                            style: const TextStyle(
                                color: black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                              onTap: widget.onLikePressListener!,
                              child: Icon(
                                widget.comment.likes!.contains(_currentUid)
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                color:
                                    widget.comment.likes!.contains(_currentUid)
                                        ? Colors.red
                                        : black,
                                size: 20,
                              )),
                        ],
                      ),
                      sizeVertical(4),
                      Text(
                        "${widget.comment.description}",
                        style: const TextStyle(
                            color: black,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                      sizeVertical(4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('dd MMM yyyy')
                                .format(widget.comment.createAt!.toDate()),
                            style: const TextStyle(
                              color: black,
                              fontSize: 12,
                            ),
                          ),
                          sizeHorizontal(15),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isUserReplaying = !_isUserReplaying;
                                });
                              },
                              child: const Text(
                                "Replay",
                                style: TextStyle(color: black, fontSize: 12),
                              )),
                          sizeHorizontal(15),
                          GestureDetector(
                            onTap: () {
                              widget.comment.totalReplays == 0
                                  ? toast("no replays")
                                  : BlocProvider.of<ReplayCubit>(context)
                                      .getReplays(
                                          replay: ReplayEntity(
                                              postId: widget.comment.postId,
                                              commentId:
                                                  widget.comment.commentId));
                            },
                            child: const Text(
                              "View Replays",
                              style: TextStyle(color: black, fontSize: 12),
                            ),
                          ),
                          sizeHorizontal(15),
                        ],
                      ),
                      BlocBuilder<ReplayCubit, ReplayState>(
                        builder: (context, replayState) {
                          if (replayState is ReplayLoaded) {
                            final replays = replayState.replays
                                .where((element) =>
                                    element.commentId ==
                                    widget.comment.commentId)
                                .toList();
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: replays.length,
                                itemBuilder: (context, index) {
                                  return SingleReplayWidget(
                                    replay: replays[index],
                                    onLongPressListener: () {
                                      _openBottomModalSheet(
                                          context: context,
                                          replay: replays[index]);
                                    },
                                    onLikeClickListener: () {
                                      _likeReplay(replay: replays[index]);
                                    },
                                  );
                                });
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                      _isUserReplaying == true
                          ? sizeVertical(10)
                          : sizeVertical(0),
                      _isUserReplaying == true
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                FormContainerWidget(
                                    hintText: "Post your replay...",
                                    controller: _replayDescriptionController),
                                sizeVertical(10),
                                GestureDetector(
                                  onTap: () {
                                    _createReplay();
                                  },
                                  child: const Text(
                                    "Post",
                                    style: TextStyle(color: black),
                                  ),
                                )
                              ],
                            )
                          : const SizedBox(
                              width: 0,
                              height: 0,
                            )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _createReplay() {
    BlocProvider.of<ReplayCubit>(context)
        .createReplay(
            replay: ReplayEntity(
      replayId: const Uuid().v1(),
      createAt: Timestamp.now(),
      likes: [],
      username: widget.currentUser!.username,
      userProfileUrl: widget.currentUser!.profileUrl,
      creatorUid: widget.currentUser!.uid,
      postId: widget.comment.postId,
      commentId: widget.comment.commentId,
      description: _replayDescriptionController.text,
    ))
        .then((value) {
      setState(() {
        _replayDescriptionController.clear();
        _isUserReplaying = false;
      });
    });
  }

  _openBottomModalSheet(
      {required BuildContext context, required ReplayEntity replay}) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 150,
            decoration: BoxDecoration(color: darkPurpleColor.withOpacity(.8)),
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
                            color: white),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Divider(
                      thickness: 1,
                      color: white,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          _deleteReplay(replay: replay);
                        },
                        child: const Text(
                          "Delete Replay",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: white),
                        ),
                      ),
                    ),
                    sizeVertical(7),
                    const Divider(
                      thickness: 1,
                      color: white,
                    ),
                    sizeVertical(7),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, PageConsts.updateReplayPage,
                              arguments: replay);

                          // Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePostPage()));
                        },
                        child: const Text(
                          "Update Replay",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: white),
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

  _deleteReplay({required ReplayEntity replay}) {
    BlocProvider.of<ReplayCubit>(context).deleteReplay(
        replay: ReplayEntity(
            postId: replay.postId,
            commentId: replay.commentId,
            replayId: replay.replayId));
  }

  _likeReplay({required ReplayEntity replay}) {
    BlocProvider.of<ReplayCubit>(context).likeReplay(
        replay: ReplayEntity(
            postId: replay.postId,
            commentId: replay.commentId,
            replayId: replay.replayId));
  }
}
