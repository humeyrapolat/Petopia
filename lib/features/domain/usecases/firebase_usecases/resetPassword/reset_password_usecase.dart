import 'package:petopia/features/domain/repo/firebase_repository.dart';

class ResetPasswordUseCase {
  final FirebaseRepository repository;

  ResetPasswordUseCase({required this.repository});

  Future<void> call(String email) {
    return repository.passwordReset(email);
  }
}
