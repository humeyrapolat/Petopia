import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/post/post_entity.dart';
import '../../../../domain/usecases/firebase_usecases/post/read_single_post_usecase.dart';

part 'get_single_post_state.dart';

class GetSinglePostCubit extends Cubit<GetSinglePostState> {
  final ReadSinglePostUseCase readSinglePostUseCase;
  GetSinglePostCubit({required this.readSinglePostUseCase})
      : super(GetSinglePostInitial());

  StreamSubscription? _streamSubscription;

  Future<void> getSinglePost({required String postId}) async {
    emit(GetSinglePostLoading());
    try {
      final streamResponse = readSinglePostUseCase.call(postId);
      _streamSubscription = streamResponse.listen((posts) {
        emit(GetSinglePostLoaded(post: posts.first));
        dispose();
      });
    } on SocketException catch (_) {
      emit(GetSinglePostFailure());
    } catch (_) {
      emit(GetSinglePostFailure());
    }
  }

  dispose() {
    _streamSubscription?.cancel();
  }
}
