import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petopia/features/domain/entities/comment/comment_entity.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/user/get_current_uid_usecase.dart';
import 'package:petopia/features/presentation/widgets/form_container_widget.dart';
import 'package:petopia/injection_container.dart' as di;
import 'package:petopia/profile_widget.dart';
import 'package:petopia/util/consts.dart';

class SingleCommentWidget extends StatefulWidget {
  final CommentEntity comment;
  final VoidCallback? onLongPressListener;
  final VoidCallback? onLikePressListener;

  const SingleCommentWidget({
    super.key,
    required this.comment,
    this.onLongPressListener,
    this.onLikePressListener,
  });

  @override
  State<SingleCommentWidget> createState() => _SingleCommentWidgetState();
}

class _SingleCommentWidgetState extends State<SingleCommentWidget> {
  bool isReply = false;

  String _currentUUid = " ";

  @override
  void initState() {
    di.sl<GetCurrentUidUseCase>().call().then((value) {
      setState(() {
        _currentUUid = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: widget.onLongPressListener,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
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
                            widget.comment.username!,
                            style: const TextStyle(
                                color: black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                              onTap: widget.onLikePressListener!,
                              child: Icon(
                                widget.comment.likes!.contains(_currentUUid)
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                color:
                                    widget.comment.likes!.contains(_currentUUid)
                                        ? Colors.red
                                        : black,
                                size: 20,
                              )),
                        ],
                      ),
                      sizeVertical(4),
                      Text(
                        widget.comment.description!,
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
                                isReply = !isReply;
                              });
                            },
                            child: const Text(
                              "Reply",
                              style: TextStyle(
                                color: black,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          sizeHorizontal(15),
                          const Text(
                            "View Replays",
                            style: TextStyle(
                              color: black,
                              fontSize: 12,
                            ),
                          ),
                          sizeHorizontal(15),
                        ],
                      ),
                      isReply ? sizeVertical(10) : sizeVertical(0),
                      isReply
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const FormContainerWidget(
                                  hintText: "Add a comment...",
                                ),
                                sizeVertical(10),
                                const Text(
                                  "Post",
                                  style: TextStyle(
                                      color: darkPinkColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
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
}
