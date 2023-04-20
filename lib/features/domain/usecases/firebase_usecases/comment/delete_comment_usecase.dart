import '../../../entities/comment/comment_entity.dart';
import '../../../repo/firebase_repository.dart';

class DeleteCommentUseCase {
  final FirebaseRepository repository;

  DeleteCommentUseCase({required this.repository});

  Future<void> call(CommentEntity comment) {
    return repository.deleteComment(comment);
  }
}