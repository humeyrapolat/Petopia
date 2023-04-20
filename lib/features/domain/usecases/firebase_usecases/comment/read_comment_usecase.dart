import '../../../entities/comment/comment_entity.dart';
import '../../../repo/firebase_repository.dart';

class ReadCommentUseCase {
  final FirebaseRepository repository;

  ReadCommentUseCase({required this.repository});

  Stream<List<CommentEntity>> call(String postId) {
    return repository.readComments(postId);
  }
}