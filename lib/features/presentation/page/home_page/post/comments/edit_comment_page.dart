import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petopia/features/presentation/page/home_page/post/comments/widgets/edit_comment_main_widget.dart';
import 'package:petopia/injection_container.dart' as di;

import '../../../../../domain/entities/comment/comment_entity.dart';
import '../../../../cubit/comment/comment_cubit.dart';


class EditCommentPage extends StatelessWidget {
  final CommentEntity comment;

  const EditCommentPage({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CommentCubit>(
      create: (context) => di.sl<CommentCubit>(),
      child: EditCommentMainWidget(comment: comment),
    );
  }
}