import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:petopia/features/domain/entities/lost/lost_entity.dart';
import 'package:petopia/features/presentation/cubit/lost/lost_cubit.dart';
import 'package:petopia/injection_container.dart' as di;
import '../../../../util/consts.dart';
import 'widget/single_lost_card_widget.dart';

class LostAnimalPage extends StatelessWidget {
  const LostAnimalPage({super.key});

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
                  : ListView.builder(
                      itemCount: lostState.losts.length,
                      itemBuilder: (context, index) {
                        final lost = lostState.losts[index];
                        return BlocProvider(
                          create: (context) => di.sl<LostCubit>(),
                          child: SinglePageLostCardWidget(lostEntity: lost),
                        );
                      },
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
