import 'package:petopia/features/domain/entities/adoption/adoption_entity.dart';
import 'package:petopia/features/domain/entities/lost/lost_entity.dart';
import 'package:petopia/features/domain/repo/firebase_repository.dart';

class ReadLostUseCase {
  final FirebaseRepository repository;

  ReadLostUseCase({required this.repository});

  Stream<List<LostEntity>> call(LostEntity lostEntity) {
    return repository.readLost(lostEntity);
  }
}
