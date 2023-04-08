import 'package:petopia/features/domain/entities/post/post_entity.dart';
import 'package:petopia/features/domain/repo/firebase_repository.dart';

class LikePostUseCase {
  final FirebaseRepository repository;

  LikePostUseCase({required this.repository});

  Future<void> call(PostEntity post) {
    return repository.likePost(post);
  }
}