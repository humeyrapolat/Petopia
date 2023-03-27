import 'package:petopia/features/domain/entities/user/user_entity.dart';
import 'package:petopia/features/domain/repo/firebase_repository.dart';

class SignInUserUseCase {
  final FirebaseRepository repository;

  SignInUserUseCase({required this.repository});

  Future<void> call(UserEntity user) {
    return repository.signInUser(user);
  }
}