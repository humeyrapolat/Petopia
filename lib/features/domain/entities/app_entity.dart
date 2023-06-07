import 'package:petopia/features/domain/entities/post/post_entity.dart';
import 'package:petopia/features/domain/entities/animal/animal_entity.dart';

class AppEntity {
  final AnimalEntity? currentUser;
  final PostEntity? postEntity;
  final String? uid;
  final String? postId;

  AppEntity({
    this.currentUser,
    this.postEntity,
    this.uid,
    this.postId,
  });
}
