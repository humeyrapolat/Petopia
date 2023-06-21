import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petopia/features/domain/entities/lost/lost_entity.dart';

import 'dart:io';

import 'package:petopia/features/domain/usecases/firebase_usecases/lost/create_lost_usecase.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/lost/delete_lost_usecase.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/lost/read_lost_usecase.dart';

part 'lost_state.dart';

class LostCubit extends Cubit<LostState> {
  final CreateLostUseCase createLostUseCase;
  final DeleteLostUseCase deleteLostUseCase;
  final ReadLostUseCase readLostUseCase;

  LostCubit({required this.createLostUseCase, required this.deleteLostUseCase, required this.readLostUseCase})
      : super(LostInitial());

  Future<void> getLosts({required LostEntity lost}) async {
    emit(LostLoading());
    try {
      final streamResponse = readLostUseCase.call(lost);
      streamResponse.listen((losts) {
        emit(LostLoaded(losts: losts));
      });
    } on SocketException catch (_) {
      emit(LostFailure());
    } catch (_) {
      emit(LostFailure());
    }
  }

  Future<void> createLost({required LostEntity lost}) async {
    try {
      await createLostUseCase.call(lost);
    } on SocketException catch (_) {
      emit(LostFailure());
    } catch (_) {
      emit(LostFailure());
    }
  }

  Future<void> deleteLost({required LostEntity lost}) async {
    try {
      await deleteLostUseCase.call(lost);
    } on SocketException catch (_) {
      emit(LostFailure());
    } catch (_) {
      emit(LostFailure());
    }
  }
}
