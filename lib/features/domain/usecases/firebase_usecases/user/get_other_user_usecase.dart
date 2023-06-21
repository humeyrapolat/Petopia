import 'package:petopia/features/domain/entities/animal/animal_entity.dart';
import 'package:petopia/features/domain/repo/firebase_repository.dart';

class GetOtherUsersUseCase {
  final FirebaseRepository repository;

  GetOtherUsersUseCase({required this.repository});

  Stream<List<AnimalEntity>> call(String uid) {
    return repository.getOtherUsers(uid);
  }
}
