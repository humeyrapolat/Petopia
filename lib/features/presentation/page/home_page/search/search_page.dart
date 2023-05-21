import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petopia/features/presentation/cubit/post/post_cubit.dart';
import 'package:petopia/features/presentation/page/home_page/search/widget/search_main_widget.dart';
import 'package:petopia/injection_container.dart' as di;

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostCubit>(
      create: (context) => di.sl<PostCubit>(),
      child: const SearchMainWidget(),
    );
  }
}
