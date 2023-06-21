import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AdoptionEntity extends Equatable {
  final String? adoptionPostId;
  final String? creatorUid;
  final String? city;
  final String? type;
  final String? age;
  final String? profileUrl;

  final File? image;

  const AdoptionEntity({
    this.adoptionPostId,
    this.creatorUid,
    this.city,
    this.type,
    this.age,
    this.image,
    this.profileUrl,
  });

  @override
  List<Object?> get props => [
        adoptionPostId,
        creatorUid,
        city,
        type,
        age,
        image,
        profileUrl,
      ];
}
