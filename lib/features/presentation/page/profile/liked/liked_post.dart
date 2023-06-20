import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petopia/features/domain/entities/animal/animal_entity.dart';
import 'package:petopia/features/presentation/cubit/post/post_cubit.dart';
import 'package:petopia/features/presentation/page/profile/widget/liked_post_main_widget.dart';
import 'package:petopia/util/consts.dart';
import 'package:petopia/injection_container.dart' as di;

class LikedPostPage extends StatelessWidget {
  final AnimalEntity currentUser;

  const LikedPostPage({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => di.sl<PostCubit>(),
        child: likedPostMainWidget(
          currentUser: currentUser,
        ));
  }
}
