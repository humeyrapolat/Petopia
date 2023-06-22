import 'package:petopia/features/domain/entities/lost/lost_entity.dart';
import 'package:petopia/features/domain/repo/firebase_repository.dart';

class CreateLostUseCase {
  final FirebaseRepository repository;

  CreateLostUseCase({required this.repository});

  Future<void> call(LostEntity lostEntity) {
    return repository.createLost(lostEntity);
  }
}
