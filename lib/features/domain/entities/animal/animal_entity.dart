import 'dart:io';

import 'package:equatable/equatable.dart';

class AnimalEntity extends Equatable {
  final String? uid;
  final String? username;
  final String? name;
  final String? bio;
  final String? website;
  final String? phoneNumber;
  final String? city;
  final String? district;
  final String? email;
  final String? birthdate;
  final String? breed;
  final String? gender;
  final String? type;
  final String? profileUrl;
  final List? followers;
  final List? following;
  final List? favorites;
  final num? totalFollowers;
  final num? totalFollowing;
  final num? totalPosts;
  final List<String>? likedPosts;
  final List<String>? lostPosts;
  final List<String>? adoptionPosts;

  final File? imageFile;
  final String? password;
  final String? otherUid;

  const AnimalEntity({
    this.imageFile,
    this.uid,
    this.username,
    this.name,
    this.bio,
    this.website,
    this.phoneNumber,
    this.city,
    this.district,
    this.email,
    this.birthdate,
    this.breed,
    this.gender,
    this.type,
    this.profileUrl,
    this.followers,
    this.following,
    this.favorites,
    this.totalFollowers,
    this.totalFollowing,
    this.totalPosts,
    this.password,
    this.otherUid,
    this.likedPosts,
    this.adoptionPosts,
    this.lostPosts,
  });

  @override
  List<Object?> get props => [
        imageFile,
        uid,
        username,
        name,
        bio,
        website,
        email,
        phoneNumber,
        city,
        district,
        birthdate,
        breed,
        gender,
        type,
        profileUrl,
        followers,
        following,
        favorites,
        totalFollowers,
        totalFollowing,
        totalPosts,
        password,
        otherUid,
        likedPosts,
        adoptionPosts,
        lostPosts,
      ];
}
