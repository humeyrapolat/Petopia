import '../../../entities/animal/animal_entity.dart';
import '../../../repo/firebase_repository.dart';

class GetFavUsersUseCase {
  final FirebaseRepository repository;

  GetFavUsersUseCase({required this.repository});

  Future<void> call(AnimalEntity user) {
    return repository.getFavUsers(user);
  }
}
