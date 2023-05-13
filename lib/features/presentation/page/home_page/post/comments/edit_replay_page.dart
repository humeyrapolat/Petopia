import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petopia/features/presentation/page/home_page/post/comments/widgets/edit_replay_main_widget.dart';
import 'package:petopia/injection_container.dart' as di;

import '../../../../../domain/entities/replay/replay_entity.dart';
import '../../../../cubit/replay/replay_cubit.dart';

class EditReplayPage extends StatelessWidget {
  final ReplayEntity replay;

  const EditReplayPage({Key? key, required this.replay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReplayCubit>(
      create: (context) => di.sl<ReplayCubit>(),
      child: EditReplayMainWidget(replay: replay),
    );
  }
}