import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:petopia/features/domain/entities/lost/lost_entity.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/user/get_current_uid_usecase.dart';
import 'package:petopia/features/presentation/cubit/lost/lost_cubit.dart';
import 'package:petopia/injection_container.dart' as di;
import 'package:petopia/util/consts.dart';

class SinglePageLostCardWidget extends StatefulWidget {
  final LostEntity lostEntity;
  const SinglePageLostCardWidget({super.key, required this.lostEntity});

  @override
  State<SinglePageLostCardWidget> createState() => _SinglePagelostEntityCardWidget();
}

class _SinglePagelostEntityCardWidget extends State<SinglePageLostCardWidget> {
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
    return SizedBox(
      height: 50,
      child: ListTile(
        onLongPress: () => deletelostEntity(),
        onTap: () {
          Navigator.pushNamed(context, PageConsts.chatPage);
        },
        title: Text(
          widget.lostEntity.city!,
          style: const TextStyle(color: darkGreenColor, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          widget.lostEntity.name!,
          style: const TextStyle(color: darkGreenColor, fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(
          Iconsax.message,
          color: darkGreenColor,
        ),
      ),
    );
  }

  deletelostEntity() {
    BlocProvider.of<LostCubit>(context)
        .deleteLost(lost: LostEntity(lostAnimalId: widget.lostEntity.lostAnimalId))
        .whenComplete(() => Navigator.pop(context));
  }
}
