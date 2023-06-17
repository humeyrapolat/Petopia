import 'package:petopia/features/domain/entities/lost/lost_entity.dart';
import 'package:petopia/features/domain/repo/firebase_repository.dart';

class DeleteLostUseCase {
  final FirebaseRepository repository;

  DeleteLostUseCase({required this.repository});

  Future<void> call(LostEntity lostEntity) {
    return repository.deleteLost(lostEntity);
  }
}
