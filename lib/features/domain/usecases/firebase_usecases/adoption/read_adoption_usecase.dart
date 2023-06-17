import 'package:petopia/features/domain/entities/adoption/adoption_entity.dart';
import 'package:petopia/features/domain/repo/firebase_repository.dart';

class ReadAdoptionUseCase {
  final FirebaseRepository repository;

  ReadAdoptionUseCase({required this.repository});

  Stream<List<AdoptionEntity>> call(AdoptionEntity adoptionEntity) {
    return repository.readAdoption(adoptionEntity);
  }
}
