import '../../../entities/user/user_entity.dart';
import '../../../repo/firebase_repository.dart';

class FollowUnfollowUseCase {
  final FirebaseRepository repository;

  FollowUnfollowUseCase({required this.repository});

  Future<void> call(UserEntity user) {
    return repository.followUnfollowUser(user);
  }
}
