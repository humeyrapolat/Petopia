import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petopia/features/domain/entities/app_entity.dart';
import 'package:petopia/features/presentation/cubit/comment/comment_cubit.dart';
import 'package:petopia/features/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:petopia/features/presentation/page/home_page/post/comments/widgets/comment_main_widget.dart';
import 'package:petopia/injection_container.dart' as di;

class CommentPage extends StatelessWidget {
  final AppEntity appEntity;
  const CommentPage({super.key, required this.appEntity});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CommentCubit>(
          create: (context) => di.sl<CommentCubit>(),
        ),
        BlocProvider<GetSingleUserCubit>(
          create: (context) => di.sl<GetSingleUserCubit>(),
        ),
      ],
      child: CommentMainWidget(appEntity: appEntity),
    );
  }
}
