import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petopia/features/domain/entities/adoption/adoption_entity.dart';
import 'package:petopia/features/domain/entities/lost/lost_entity.dart';
import 'package:petopia/features/domain/entities/post/post_entity.dart';

class LostModel extends LostEntity {
  final String? lostAnimalId;
  final String? creatorUid;
  final String? city;
  final String? imageUrl;
  final String? name;
  final DateTime? date;
  final int? age;
  final bool? isKnowName;

  const LostModel({
    this.lostAnimalId,
    this.creatorUid,
    this.city,
    this.age,
    this.imageUrl,
    this.name,
    this.date,
    this.isKnowName,
  }) : super(
          creatorUid: creatorUid,
          city: city,
          age: age,
          imageUrl: imageUrl,
          name: name,
          date: date,
          isKnowName: isKnowName,
        );

  factory LostModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return LostModel(
      lostAnimalId: snap.id,
      creatorUid: snapshot['creatorUid'],
      city: snapshot['city'],
      age: snapshot['age'],
      imageUrl: snapshot['imageUrl'],
      name: snapshot['name'],
      date: snapshot['date'].toDate(),
      isKnowName: snapshot['isKnowName'],
    );
  }

  Map<String, dynamic> toJson() => {
        'lostAnimalId': lostAnimalId,
        'creatorUid': creatorUid,
        'city': city,
        'age': age,
        'imageUrl': imageUrl,
        'name': name,
        'date': date,
        'isKnowName': isKnowName,
      };
}
