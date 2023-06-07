import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petopia/features/domain/entities/animal/animal_entity.dart';
import 'package:petopia/features/presentation/page/home_page/post/widgets/upload_post_main_widget.dart';
import 'package:petopia/injection_container.dart' as di;
import 'package:petopia/features/presentation/cubit/post/post_cubit.dart';

class UploadPostPage extends StatelessWidget {
  final AnimalEntity currentUser;

  const UploadPostPage({Key? key, required this.currentUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostCubit>(
      create: (context) => di.sl<PostCubit>(),
      child: UploadPostMainWidget(currentUser: currentUser),
    );
  }
}
