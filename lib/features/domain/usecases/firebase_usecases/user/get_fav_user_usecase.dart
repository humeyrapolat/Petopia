import 'package:petopia/features/domain/entities/animal/animal_entity.dart';
import 'package:petopia/features/domain/repo/firebase_repository.dart';

class GetFavUsersUseCase {
  final FirebaseRepository repository;

  GetFavUsersUseCase({required this.repository});

  Future<bool> call(AnimalEntity user) {
    return repository.getFavUsers(user);
  }
}
