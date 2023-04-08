import 'package:petopia/features/domain/entities/post/post_entity.dart';
import 'package:petopia/features/domain/repo/firebase_repository.dart';

class ReadPostUseCase {
  final FirebaseRepository repository;

  ReadPostUseCase({required this.repository});

  Stream<List<PostEntity>> call(PostEntity post) {
    return repository.readPost(post);
  }
}