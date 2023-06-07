import '../../../entities/animal/animal_entity.dart';
import '../../../repo/firebase_repository.dart';

class FollowUnfollowUseCase {
  final FirebaseRepository repository;

  FollowUnfollowUseCase({required this.repository});

  Future<void> call(AnimalEntity user) {
    return repository.followUnfollowUser(user);
  }
}
