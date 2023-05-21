import 'dart:async';
import 'dart:io';
//package imports
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petopia/features/domain/entities/post/post_entity.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/post/create_post_usecase.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/post/delete_post_usecase.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/post/like_post_usecase.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/post/read_post_usecase.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/post/update_post_usecase.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  final CreatePostUseCase createPostUseCase;
  final UpdatePostUseCase updatePostUseCase;
  final DeletePostUseCase deletePostUseCase;
  final LikePostUseCase likePostUseCase;
  final ReadPostUseCase readPostUseCase;

  PostCubit({
    required this.createPostUseCase,
    required this.updatePostUseCase,
    required this.deletePostUseCase,
    required this.likePostUseCase,
    required this.readPostUseCase,
  }) : super(PostInitial());

  StreamSubscription? _streamSubscription;

  Future<void> getPosts({required PostEntity post}) async {
    emit(PostLoading());
    try {
      final streamResponse = readPostUseCase.call(post);
      _streamSubscription = streamResponse.listen((posts) {
        emit(PostLoaded(posts: posts));
        dispose();
      });
    } on SocketException catch (_) {
      emit(PostFailure());
    } catch (_) {
      emit(PostFailure());
    }
  }

  Future<void> createPost({required PostEntity post}) async {
    try {
      await createPostUseCase.call(post);
    } on SocketException catch (_) {
      emit(PostFailure());
    } catch (_) {
      emit(PostFailure());
    }
  }

  Future<void> updatePost({required PostEntity post}) async {
    try {
      await updatePostUseCase.call(post);
    } on SocketException catch (_) {
      emit(PostFailure());
    } catch (_) {
      emit(PostFailure());
    }
  }

  Future<void> deletePost({required PostEntity post}) async {
    try {
      await deletePostUseCase.call(post);
    } on SocketException catch (_) {
      emit(PostFailure());
    } catch (_) {
      emit(PostFailure());
    }
  }

  Future<void> likePost({required PostEntity post}) async {
    try {
      await likePostUseCase.call(post);
    } on SocketException catch (_) {
      emit(PostFailure());
    } catch (_) {
      emit(PostFailure());
    }
  }

  dispose() {
    _streamSubscription?.cancel();
  }
}
