import 'package:petopia/features/domain/entities/animal/animal_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnimalModel extends AnimalEntity {
  final String? uid;
  final String? username;
  final String? name;
  final String? bio;
  final String? phoneNumber;
  final String? website;
  final String? email;
  final String? city;
  final String? district;
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

  const AnimalModel(
      {this.uid,
      this.username,
      this.name,
      this.bio,
      this.website,
      this.email,
      this.city,
      this.district,
      this.phoneNumber,
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
      this.likedPosts,
      this.totalPosts,
      this.lostPosts,
      this.adoptionPosts})
      : super(
          uid: uid,
          username: username,
          name: name,
          bio: bio,
          website: website,
          phoneNumber: phoneNumber,
          email: email,
          city: city,
          district: district,
          birthdate: birthdate,
          breed: breed,
          gender: gender,
          type: type,
          profileUrl: profileUrl,
          followers: followers,
          following: following,
          favorites: favorites,
          likedPosts: likedPosts,
          totalFollowers: totalFollowers,
          totalFollowing: totalFollowing,
          totalPosts: totalPosts,
          lostPosts: lostPosts,
          adoptionPosts: adoptionPosts,
        );

  factory AnimalModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return AnimalModel(
        uid: snapshot['uid'],
        username: snapshot['username'],
        name: snapshot['name'],
        bio: snapshot['bio'],
        city: snapshot['city'],
        district: snapshot['district'],
        phoneNumber: snapshot['phoneNumber'],
        website: snapshot['website'],
        email: snapshot['email'],
        birthdate: snapshot['birthdate'],
        breed: snapshot['breed'],
        gender: snapshot['gender'],
        type: snapshot['type'],
        profileUrl: snapshot['profileUrl'],
        followers: List.from(snap.get('followers')),
        following: List.from(snap.get('following')),
        favorites: List.from(snap.get('favorites')),
        totalFollowers: snapshot['totalFollowers'],
        totalFollowing: snapshot['totalFollowing'],
        totalPosts: snapshot['totalPosts']);
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'username': username,
      'name': name,
      'bio': bio,
      'website': website,
      'email': email,
      'city': city,
      'district': district,
      'phoneNumber': phoneNumber,
      'birthdate': birthdate,
      'breed': breed,
      'gender': gender,
      'type': type,
      'profileUrl': profileUrl,
      'likedPosts': likedPosts,
      'followers': followers,
      'following': following,
      'favorites': favorites,
      'totalFollowers': totalFollowers,
      'totalFollowing': totalFollowing,
      'totalPosts': totalPosts,
      'lostPosts': lostPosts,
      'adoptionPosts': adoptionPosts,
    };
  }
}
