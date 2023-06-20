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
    return Card(
      elevation: 3,
      shadowColor: Colors.grey.withOpacity(0.5),
      child: InkWell(
        onLongPress: () => deletelostEntity(),
        onTap: () {
          Navigator.pushNamed(context, PageConsts.chatPage);
        },
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sizeVertical(10),
                    Text(
                      widget.lostEntity.description!,
                      style: const TextStyle(color: black, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Iconsax.location,
                          color: Colors.grey,
                        ),
                        sizeHorizontal(8),
                        Text(
                          widget.lostEntity.city!,
                          style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              sizeVertical(10),
              Container(
                width: 350,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    image: NetworkImage(widget.lostEntity.imageUrl ??
                        "https://i.pinimg.com/474x/4b/2a/7f/4b2a7fd2bc5fcddd91a28d3421b418b2.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              const Icon(
                Iconsax.call,
                color: black,
              ),
            ],
          ),
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
