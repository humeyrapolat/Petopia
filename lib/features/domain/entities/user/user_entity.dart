import 'dart:io';

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? uid;
  final String? username;
  final String? name;
  final String? bio;
  final String? website;
  final String? email;
  final DateTime? birthdate;
  final String? breed;
  final String? gender;
  final String? profileUrl;
  final List? followers;
  final List? following;
  final num? totalFollowers;
  final num? totalFollowing;
  final num? totalPosts;

  final File? imageFile;
  final String? password;
  final String? otherUid;

  const UserEntity({
    this.imageFile,
    this.uid,
    this.username,
    this.name,
    this.bio,
    this.website,
    this.email,
    this.birthdate,
    this.breed,
    this.gender,
    this.profileUrl,
    this.followers,
    this.following,
    this.totalFollowers,
    this.totalFollowing,
    this.totalPosts,
    this.password,
    this.otherUid,
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
        birthdate,
        breed,
        gender,
        profileUrl,
        followers,
        following,
        totalFollowers,
        totalFollowing,
        totalPosts,
        password,
        otherUid,
      ];
}
