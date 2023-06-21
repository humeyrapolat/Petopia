import 'package:petopia/features/domain/entities/adoption/adoption_entity.dart';
import 'package:petopia/features/domain/repo/firebase_repository.dart';

class CreateAdoptionUseCase {
  final FirebaseRepository repository;

  CreateAdoptionUseCase({required this.repository});

  Future<void> call(AdoptionEntity adoptionEntity) {
    return repository.createAdoption(adoptionEntity);
  }
}
