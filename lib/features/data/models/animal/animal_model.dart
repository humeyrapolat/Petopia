import 'package:petopia/features/domain/entities/animal/animal_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnimalModel extends AnimalEntity {
  final String? uid;
  final String? username;
  final String? name;
  final String? bio;
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
      this.birthdate,
      this.breed,
      this.gender,
      this.type,
      this.profileUrl,
      this.followers,
      this.following,
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
      website: snapshot['website'],
      email: snapshot['email'],
      city: snapshot['city'],
      district: snapshot['district'],
      birthdate: snapshot['birthdate'],
      breed: snapshot['breed'],
      gender: snapshot['gender'],
      type: snapshot['type'],
      profileUrl: snapshot['profileUrl'],
      likedPosts: List.from(snap.get('likedPosts')),
      followers: List.from(snap.get('followers')),
      following: List.from(snap.get('following')),
      totalFollowers: snapshot['totalFollowers'],
      totalFollowing: snapshot['totalFollowing'],
      totalPosts: snapshot['totalPosts'],
      lostPosts: List.from(snap.get('lostPosts')),
      adoptionPosts: List.from(
        snap.get('adoptionPosts'),
      ),
    );
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
      'birthdate': birthdate,
      'breed': breed,
      'gender': gender,
      'type': type,
      'profileUrl': profileUrl,
      'likedPosts': likedPosts,
      'followers': followers,
      'following': following,
      'totalFollowers': totalFollowers,
      'totalFollowing': totalFollowing,
      'totalPosts': totalPosts,
      'lostPosts': lostPosts,
      'adoptionPosts': adoptionPosts,
    };
  }
}
