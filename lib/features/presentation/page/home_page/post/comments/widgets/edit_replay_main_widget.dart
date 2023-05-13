import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../util/consts.dart';
import '../../../../../../domain/entities/replay/replay_entity.dart';
import '../../../../../cubit/replay/replay_cubit.dart';
import '../../../../../widgets/button_container_widget.dart';
import '../../../../profile/widget/profile_form_widget.dart';

class EditReplayMainWidget extends StatefulWidget {
  final ReplayEntity replay;
  const EditReplayMainWidget({Key? key, required this.replay}) : super(key: key);

  @override
  State<EditReplayMainWidget> createState() => _EditReplayMainWidgetState();
}

class _EditReplayMainWidgetState extends State<EditReplayMainWidget> {

  TextEditingController? _descriptionController;

  bool _isReplayUpdating = false;

  @override
  void initState() {
    _descriptionController = TextEditingController(text: widget.replay.description);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: darkPurpleColor,
        title: Text("Edit Replay"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(
          children: [
            ProfileFormWidget(
              title: "description",
              controller: _descriptionController,
            ),
            sizeVertical(10),
            ButtonContainerWidget(
              color: darkPurpleColor,
              text: "Save Changes",
              onTapListener: () {
                _editReplay();
              },
            ),
            sizeVertical(10),
            _isReplayUpdating == true?Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Updating...", style: TextStyle(color: Colors.white),),
                sizeHorizontal(10),
                CircularProgressIndicator(),
              ],
            ) : Container(width: 0, height: 0,)
          ],
        ),
      ),
    );
  }

  _editReplay() {
    setState(() {
      _isReplayUpdating = true;
    });
    BlocProvider.of<ReplayCubit>(context).updateReplay(replay: ReplayEntity(
        postId: widget.replay.postId,
        commentId: widget.replay.commentId,
        replayId: widget.replay.replayId,
        description: _descriptionController!.text
    )).then((value) {
      setState(() {
        _isReplayUpdating = false;
        _descriptionController!.clear();
      });
      Navigator.pop(context);
    });
  }
}