import 'package:equatable/equatable.dart';

class LostEntity extends Equatable {
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

  const LostEntity({
    this.lostAnimalId,
    this.creatorUid,
    this.city,
    this.date,
    this.imageUrl,
    this.district,
    this.description,
    this.isWithMe,
    this.isinjured,
    this.isMine,
  });

  @override
  List<Object?> get props => [
        lostAnimalId,
        creatorUid,
        city,
        district,
        date,
        description,
        isWithMe,
        isinjured,
        imageUrl,
        isMine,
      ];
}
