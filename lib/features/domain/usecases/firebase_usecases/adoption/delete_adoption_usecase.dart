import 'package:petopia/features/domain/entities/adoption/adoption_entity.dart';
import 'package:petopia/features/domain/repo/firebase_repository.dart';

class DeleteAdoptionUseCase {
  final FirebaseRepository repository;

  DeleteAdoptionUseCase({required this.repository});

  Future<void> call(AdoptionEntity adoptionEntity) {
    return repository.deleteAdoption(adoptionEntity);
  }
}
