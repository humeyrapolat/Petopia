import '../../../entities/animal/animal_entity.dart';
import '../../../repo/firebase_repository.dart';

class GetSingleOtherUserUseCase {
  final FirebaseRepository repository;

  GetSingleOtherUserUseCase({required this.repository});

  Stream<List<AnimalEntity>> call(String otherUid) {
    return repository.getSingleOtherUser(otherUid);
  }
}
