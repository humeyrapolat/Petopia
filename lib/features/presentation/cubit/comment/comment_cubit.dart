import 'dart:async';
import 'dart:io';
//package imports
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petopia/features/domain/entities/comment/comment_entity.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/comment/create_comment_usecase.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/comment/delete_comment_usecase.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/comment/like_comment_usecase.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/comment/read_comment_usecase.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/comment/update_comment_usecase.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  final CreateCommentUseCase createCommentUseCase;
  final DeleteCommentUseCase deleteCommentUseCase;
  final LikeCommentUseCase likeCommentUseCase;
  final ReadCommentUseCase readCommentsUseCase;
  final UpdateCommentUseCase updateCommentUseCase;
  CommentCubit(
      {required this.updateCommentUseCase,
      required this.readCommentsUseCase,
      required this.likeCommentUseCase,
      required this.deleteCommentUseCase,
      required this.createCommentUseCase})
      : super(CommentInitial());

  StreamSubscription? _streamSubscription;

  Future<void> getComments({required String postId}) async {
    emit(CommentLoading());
    try {
      final streamResponse = readCommentsUseCase.call(postId);
      _streamSubscription = streamResponse.listen((comments) {
        emit(CommentLoaded(comments: comments));
        dispose();
      });
    } on SocketException catch (_) {
      emit(CommentFailure());
    } catch (_) {
      emit(CommentFailure());
    }
  }

  Future<void> likeComment({required CommentEntity comment}) async {
    try {
      await likeCommentUseCase.call(comment);
    } on SocketException catch (_) {
      emit(CommentFailure());
    } catch (_) {
      emit(CommentFailure());
    }
  }

  Future<void> deleteComment({required CommentEntity comment}) async {
    try {
      await deleteCommentUseCase.call(comment);
    } on SocketException catch (_) {
      emit(CommentFailure());
    } catch (_) {
      emit(CommentFailure());
    }
  }

  Future<void> createComment({required CommentEntity comment}) async {
    try {
      await createCommentUseCase.call(comment);
    } on SocketException catch (_) {
      emit(CommentFailure());
    } catch (_) {
      emit(CommentFailure());
    }
  }

  Future<void> updateComment({required CommentEntity comment}) async {
    try {
      await updateCommentUseCase.call(comment);
    } on SocketException catch (_) {
      emit(CommentFailure());
    } catch (_) {
      emit(CommentFailure());
    }
  }

  dispose() {
    _streamSubscription?.cancel();
  }
}