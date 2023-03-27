import 'package:petopia/features/domain/entities/user/user_entity.dart';
import 'package:petopia/features/domain/repo/firebase_repository.dart';

class CreateUserUserCase {
  final FirebaseRepository repository;

  CreateUserUserCase({required this.repository});

  Future<void> call(UserEntity user) {
    return repository.createUser(user);
  }
}