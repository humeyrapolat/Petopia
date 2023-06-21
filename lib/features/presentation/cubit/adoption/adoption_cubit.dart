import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petopia/features/domain/entities/adoption/adoption_entity.dart';

import 'dart:io';

import 'package:petopia/features/domain/usecases/firebase_usecases/adoption/create_adoption_usecase.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/adoption/delete_adoption_usecase.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/adoption/read_adoption_usecase.dart';

part 'adoption_state.dart';

class AdoptionCubit extends Cubit<AdoptionState> {
  final CreateAdoptionUseCase createAdoptionUseCase;
  final DeleteAdoptionUseCase deleteAdoptionUseCase;
  final ReadAdoptionUseCase readAdoptionUseCase;

  AdoptionCubit(
      {required this.createAdoptionUseCase, required this.deleteAdoptionUseCase, required this.readAdoptionUseCase})
      : super(AdoptionInitial());

  Future<void> getAdoptions({required AdoptionEntity adoption}) async {
    emit(AdoptionLoading());
    try {
      final streamResponse = readAdoptionUseCase.call(adoption);
      streamResponse.listen((adoptions) {
        emit(AdoptionLoaded(adoptions: adoptions));
      });
    } on SocketException catch (_) {
      emit(AdoptionFailure());
    } catch (_) {
      emit(AdoptionFailure());
    }
  }

  Future<void> createAdoption(AdoptionEntity adoption) async {
    try {
      await createAdoptionUseCase.call(adoption);
    } on SocketException catch (_) {
      emit(AdoptionFailure());
    } catch (_) {
      emit(AdoptionFailure());
    }
  }

  Future<void> deleteAdoption({required AdoptionEntity adoption}) async {
    try {
      await deleteAdoptionUseCase.call(adoption);
    } on SocketException catch (_) {
      emit(AdoptionFailure());
    } catch (_) {
      emit(AdoptionFailure());
    }
  }
}
