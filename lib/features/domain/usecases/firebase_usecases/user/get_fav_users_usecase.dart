import 'package:flutter/widgets.dart';

import '../../../entities/animal/animal_entity.dart';
import '../../../repo/firebase_repository.dart';

class GetFavUsersUseCase {
  final FirebaseRepository repository;

  GetFavUsersUseCase({required this.repository});

  Future<void> call(BuildContext context, AnimalEntity user) {
    return repository.getFavUsers(context, user);
  }
}
