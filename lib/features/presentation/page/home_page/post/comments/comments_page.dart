import 'package:flutter/material.dart';
import 'package:petopia/features/presentation/widgets/form_container_widget.dart';
import 'package:petopia/util/consts.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  bool isReply = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlueColor,
      appBar: AppBar(
        backgroundColor: darkBlueColor,
        title: const Text('Comments'),
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey),
                    ),
                    sizeHorizontal(10),
                    const Text(
                      "Username",
                      style: TextStyle(
                          color: black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          sizeVertical(10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod, nunc vel tincidunt lacinia, nunc nisl aliquam nunc, eget aliquam nunc nisl eu nunc. Sed euismod, nunc vel tincidunt lacinia, nunc nisl aliquam nunc, eget aliquam nunc nisl eu nunc.",
              style: TextStyle(
                  color: black, fontSize: 15, fontWeight: FontWeight.w400),
            ),
          ),
          sizeVertical(10),
          const Divider(
            color: darkBlueColor,
          ),
          sizeVertical(10),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey),
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
                                const Text(
                                  "Username",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                    child: const Icon(
                                  Icons.favorite_outline,
                                  color: Colors.red,
                                  size: 20,
                                )),
                              ],
                            ),
                            sizeVertical(4),
                            const Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod, nunc vel tincidunt lacinia, nunc nisl aliquam nunc, eget aliquam nunc nisl eu nunc. Sed euismod, nunc vel tincidunt lacinia, nunc nisl aliquam nunc, eget aliquam nunc nisl eu nunc.",
                              style: TextStyle(
                                  color: black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                            sizeVertical(4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "1 day ago",
                                  style: TextStyle(
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
                                            color: black,
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
          ),
          _commentSection(),
        ],
      ),
    );
  }
}

_commentSection() {
  return Container(
    width: double.infinity,
    height: 55,
    color: Colors.grey[800],
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(children: [
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: lightBlueColor),
        ),
        sizeHorizontal(10),
        Expanded(
          child: TextFormField(
            style: const TextStyle(color: lightBlueColor),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Add a comment...",
              hintStyle: TextStyle(color: lightBlueColor),
            ),
          ),
        ),
        const Text(
          "Post",
          style: TextStyle(
              color: lightBlueColor, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ]),
    ),
  );
}
