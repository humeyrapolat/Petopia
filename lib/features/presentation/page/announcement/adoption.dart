import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:petopia/features/domain/entities/adoption/adoption_entity.dart';
import 'package:petopia/features/presentation/cubit/adoption/adoption_cubit.dart';
import 'package:petopia/util/consts.dart';
import 'package:petopia/injection_container.dart' as di;

import 'widget/single_adoption_card_widget.dart';

class AdoptionPage extends StatelessWidget {
  const AdoptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AdoptionCubit>(
        create: (context) => di.sl<AdoptionCubit>()..getAdoptions(adoption: const AdoptionEntity()),
        child: BlocBuilder<AdoptionCubit, AdoptionState>(
          builder: (context, adoptionState) {
            if (adoptionState is AdoptionLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (adoptionState is AdoptionFailure) {
              toast("Some Failure occured while creating the post");
            }
            if (adoptionState is AdoptionLoaded) {
              return adoptionState.adoptions.isEmpty
                  ? _noPostsYetWidget()
                  : ListView.builder(
                      itemCount: adoptionState.adoptions.length,
                      itemBuilder: (context, index) {
                        final adoption = adoptionState.adoptions[index];
                        return BlocProvider(
                          create: (context) => di.sl<AdoptionCubit>(),
                          child: SinglePageAdoptionCardWidget(adoption: adoption),
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
