import 'package:petopia/features/domain/entities/animal/animal_entity.dart';
import 'package:petopia/features/domain/repo/firebase_repository.dart';

class GetSingleUserUseCase {
  final FirebaseRepository repository;

  GetSingleUserUseCase({required this.repository});

  Stream<List<AnimalEntity>> call(String uid) {
    return repository.getSingleUsers(uid);
  }
}
