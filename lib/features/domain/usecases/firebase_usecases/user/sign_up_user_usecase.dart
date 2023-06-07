import 'package:petopia/features/domain/entities/animal/animal_entity.dart';
import 'package:petopia/features/domain/repo/firebase_repository.dart';

class SignUpUserUseCase {
  final FirebaseRepository repository;

  SignUpUserUseCase({required this.repository});

  Future<void> call(AnimalEntity user) {
    return repository.signUpUser(user);
  }
}
