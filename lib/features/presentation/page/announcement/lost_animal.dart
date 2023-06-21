import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:petopia/features/domain/entities/animal/animal_entity.dart';
import 'package:petopia/features/domain/entities/lost/lost_entity.dart';
import 'package:petopia/features/presentation/cubit/lost/lost_cubit.dart';
import 'package:petopia/features/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:petopia/injection_container.dart' as di;
import 'package:petopia/profile_widget.dart';
import '../../../../util/consts.dart';
import 'widget/single_lost_card_widget.dart';

class FoundedLostAnimalPage extends StatefulWidget {
  final AnimalEntity currentUser;
  const FoundedLostAnimalPage({super.key, required this.currentUser});

  @override
  State<FoundedLostAnimalPage> createState() => _FoundedLostAnimalPageState();
}

class _FoundedLostAnimalPageState extends State<FoundedLostAnimalPage> {
  bool? isMine = false;

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.currentUser.uid!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LostCubit>(
        create: (context) => di.sl<LostCubit>()..getLosts(lost: const LostEntity()),
        child: BlocBuilder<LostCubit, LostState>(
          builder: (context, lostState) {
            if (lostState is LostLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (lostState is LostFailure) {
              toast("Some Failure occured while creating the post");
            }
            if (lostState is LostLoaded) {
              return lostState.losts.isEmpty
                  ? _noPostsYetWidget()
                  : Column(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: isMine, // Checkbox durumu
                              onChanged: (value) {
                                setState(() {
                                  isMine = value!;
                                });
                              },
                            ),
                            Text('Click to see only your posts'),
                          ],
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: isMine == true ? widget.currentUser.lostPosts!.length : lostState.losts.length,
                            itemBuilder: (context, index) {
                              final LostEntity foundedLost = isMine == true
                                  ? lostState.losts
                                      .where((element) => element.creatorUid == widget.currentUser.uid)
                                      .toList()[index]
                                  : lostState.losts[index];

                              final List<String>? myLostPost = widget.currentUser.lostPosts;
                              return BlocProvider(
                                  create: (context) => di.sl<LostCubit>(),
                                  child: SinglePageLostCardWidget(lostEntity: foundedLost));
                            },
                          ),
                        ),
                      ],
                    );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  _noPostsYetWidget() {
    return const Center(
      child: Text(
        "No animal for adoption yet! You can be the first one",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }
}
