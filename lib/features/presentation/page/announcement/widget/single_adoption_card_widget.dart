import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:petopia/features/domain/entities/adoption/adoption_entity.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/user/get_current_uid_usecase.dart';
import 'package:petopia/features/presentation/cubit/adoption/adoption_cubit.dart';
import 'package:petopia/injection_container.dart' as di;
import 'package:petopia/util/consts.dart';

class SinglePageAdoptionCardWidget extends StatefulWidget {
  final AdoptionEntity adoption;
  const SinglePageAdoptionCardWidget({super.key, required this.adoption});

  @override
  State<SinglePageAdoptionCardWidget> createState() => _SinglePageAdoptionCardWidget();
}

class _SinglePageAdoptionCardWidget extends State<SinglePageAdoptionCardWidget> {
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
        onLongPress: () => deleteAdoption(),
        onTap: () {
          Navigator.pushNamed(context, PageConsts.chatPage);
        },
        title: Text(
          widget.adoption.city!,
          style: const TextStyle(color: darkGreenColor, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          widget.adoption.type!,
          style: const TextStyle(color: darkGreenColor, fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(
          Iconsax.message,
          color: darkGreenColor,
        ),
      ),
    );
  }

  deleteAdoption() {
    BlocProvider.of<AdoptionCubit>(context)
        .deleteAdoption(adoption: AdoptionEntity(adoptionPostId: widget.adoption.adoptionPostId))
        .whenComplete(() => Navigator.pop(context));
  }
}
