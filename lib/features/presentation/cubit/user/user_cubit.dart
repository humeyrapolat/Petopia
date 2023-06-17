import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:petopia/features/domain/entities/animal/animal_entity.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/user/get_fav_users_usecase.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/user/get_users_usecase.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/user/update_user_usecase.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/user/follow_unfollow_user_usecase.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UpdateUserUseCase updateUserUseCase;
  final GetUsersUseCase getUsersUseCase;
  final GetFavUsersUseCase getFavUsersUseCase;
  final FollowUnfollowUseCase followUnfollowUseCase;
  UserCubit(
      {required this.followUnfollowUseCase,
      required this.updateUserUseCase,
      required this.getFavUsersUseCase,
      required this.getUsersUseCase})
      : super(UserInitial());

  Future<void> getUsers({required AnimalEntity user}) async {
    emit(UserLoading());
    try {
      final streamResponse = getUsersUseCase.call(user);
      streamResponse.listen((users) {
        emit(UserLoaded(users: users));
      });
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }

  Future<void> followUnFollowUser({required AnimalEntity user}) async {
    try {
      await followUnfollowUseCase.call(user);
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }

  Future<void> updateUser({required AnimalEntity user}) async {
    try {
      await updateUserUseCase.call(user);
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }

  Future<void> getFavUsers(
      {required BuildContext context, required AnimalEntity user}) async {
    try {
      await getFavUsersUseCase.call(context, user);
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }
}
