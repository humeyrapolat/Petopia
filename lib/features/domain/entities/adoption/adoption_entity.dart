import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AdoptionEntity extends Equatable {
  final String? adoptionPostId;
  final String? creatorUid;
  final String? city;
  final String? type;
  final num? age;

  const AdoptionEntity({
    this.adoptionPostId,
    this.creatorUid,
    this.city,
    this.type,
    this.age,
  });

  @override
  List<Object?> get props => [
        adoptionPostId,
        creatorUid,
        city,
        type,
        age,
      ];
}
