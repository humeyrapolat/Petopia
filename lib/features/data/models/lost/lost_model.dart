import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petopia/features/domain/entities/adoption/adoption_entity.dart';
import 'package:petopia/features/domain/entities/lost/lost_entity.dart';
import 'package:petopia/features/domain/entities/post/post_entity.dart';

class LostModel extends LostEntity {
  final String? lostAnimalId;
  final String? creatorUid;
  final String? city;
  final String? district;
  final DateTime? date;
  final String? description;
  final bool? isWithMe;
  final bool? isinjured;
  final String? imageUrl;
  final bool? isMine;

  const LostModel(
      {this.lostAnimalId,
      this.creatorUid,
      this.city,
      this.imageUrl,
      this.date,
      this.district,
      this.description,
      this.isWithMe,
      this.isinjured,
      this.isMine})
      : super(
          creatorUid: creatorUid,
          city: city,
          imageUrl: imageUrl,
          date: date,
          district: district,
          description: description,
          isWithMe: isWithMe,
          isinjured: isinjured,
          lostAnimalId: lostAnimalId,
          isMine: isMine,
        );

  factory LostModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return LostModel(
      lostAnimalId: snap.id,
      creatorUid: snapshot['creatorUid'],
      city: snapshot['city'],
      imageUrl: snapshot['imageUrl'],
      date: snapshot['date'].toDate(),
      district: snapshot['district'],
      description: snapshot['description'],
      isWithMe: snapshot['isWithMe'],
      isinjured: snapshot['isInjured'],
      isMine: snapshot['isMine'],
    );
  }

  Map<String, dynamic> toJson() => {
        'lostAnimalId': lostAnimalId,
        'creatorUid': creatorUid,
        'city': city,
        'imageUrl': imageUrl,
        'date': date,
        'district': district,
        'description': description,
        'isWithMe': isWithMe,
        'isInjured': isinjured,
        'isMine': isMine,
      };
}
