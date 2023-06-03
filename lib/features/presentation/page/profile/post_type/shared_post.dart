import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petopia/features/domain/entities/user/user_entity.dart';
import 'package:petopia/features/presentation/cubit/post/post_cubit.dart';
import 'package:petopia/features/presentation/page/profile/widget/shared_post_main_widget.dart';
import 'package:petopia/injection_container.dart' as di;

class SharedPostPage extends StatelessWidget {
  final UserEntity currentUser;

  const SharedPostPage({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => di.sl<PostCubit>(),
        child: SharedPostMainWidget(
          currentUser: currentUser,
        ));
  }
}
