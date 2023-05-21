import 'dart:async';
import 'dart:io';
//package imports
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petopia/features/domain/entities/user/user_entity.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/user/get_single_user_usecase.dart';

part 'get_single_user_state.dart';

class GetSingleUserCubit extends Cubit<GetSingleUserState> {
  final GetSingleUserUseCase getSingleUserUseCase;
  GetSingleUserCubit({required this.getSingleUserUseCase})
      : super(GetSingleUserInitial());

  StreamSubscription? _streamSubscription;

  Future<void> getSingleUser({required String uid}) async {
    emit(GetSingleUserLoading());
    try {
      final streamResponse = getSingleUserUseCase.call(uid);
      _streamSubscription = streamResponse.listen((users) {
        emit(GetSingleUserLoaded(user: users.first));
        dispose();
      });
    } on SocketException catch (_) {
      emit(GetSingleUserFailure());
    } catch (_) {
      emit(GetSingleUserFailure());
    }
  }

  dispose() {
    _streamSubscription?.cancel();
  }
}
