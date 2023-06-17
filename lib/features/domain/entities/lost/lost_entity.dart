import 'package:equatable/equatable.dart';

class LostEntity extends Equatable {
  final String? lostAnimalId;
  final String? creatorUid;
  final String? city;
  final String? name;
  final DateTime? date;
  final int? age;
  final bool? isKnowName;
  final String? imageUrl;

  const LostEntity(
      {this.lostAnimalId, this.creatorUid, this.city, this.age, this.name, this.date, this.isKnowName, this.imageUrl});

  @override
  List<Object?> get props => [lostAnimalId, creatorUid, city, age, name, date, isKnowName, imageUrl];
}
