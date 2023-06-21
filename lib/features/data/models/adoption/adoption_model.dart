import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petopia/features/domain/entities/adoption/adoption_entity.dart';
import 'package:petopia/features/domain/entities/post/post_entity.dart';

class AdoptionModel extends AdoptionEntity {
  final String? adoptionPostId;
  final String? creatorUid;
  final String? city;
  final String? type;
  final String? age;
  final String? profileUrl;

  const AdoptionModel({
    this.adoptionPostId,
    this.creatorUid,
    this.city,
    this.type,
    this.age,
    this.profileUrl,
  }) : super(
            adoptionPostId: adoptionPostId,
            creatorUid: creatorUid,
            city: city,
            type: type,
            age: age,
            profileUrl: profileUrl);

  factory AdoptionModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return AdoptionModel(
      creatorUid: snapshot['creatorUid'],
      adoptionPostId: snapshot['adoptionPostId'],
      city: snapshot['city'],
      type: snapshot['type'],
      age: snapshot['age'],
      profileUrl: snapshot['profileUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        "creatorUid": creatorUid,
        "adoptionPostId": adoptionPostId,
        "city": city,
        "type": type,
        "age": age,
        "profileUrl": profileUrl,
      };
}
