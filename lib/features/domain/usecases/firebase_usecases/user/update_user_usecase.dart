import 'package:petopia/features/domain/entities/animal/animal_entity.dart';
import 'package:petopia/features/domain/repo/firebase_repository.dart';

class UpdateUserUseCase {
  final FirebaseRepository repository;

  UpdateUserUseCase({required this.repository});

  Future<void> call(AnimalEntity user) {
    return repository.updateUser(user);
  }
}
