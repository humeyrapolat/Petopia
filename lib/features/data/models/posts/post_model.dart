import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petopia/features/domain/entities/post/post_entity.dart';

class PostModel extends PostEntity {
  final String? postId;
  final String? creatorUid;
  final String? username;
  final String? description;
  final String? postImageUrl;
  final List<String>? likes;
  final num? totalLikes;
  final num? totalComments;
  final Timestamp? createAt;
  final String? userProfileUrl;

  const PostModel({
    this.postId,
    this.creatorUid,
    this.username,
    this.description,
    this.postImageUrl,
    this.likes,
    this.totalLikes,
    this.totalComments,
    this.createAt,
    this.userProfileUrl,
  }) : super(
          postId: postId,
          creatorUid: creatorUid,
          username: username,
          description: description,
          postImageUrl: postImageUrl,
          likes: likes,
          totalLikes: totalLikes,
          totalComments: totalComments,
          creatAt: createAt,
          userProfileUrl: userProfileUrl,
        );

  factory PostModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return PostModel(
        postId: snapshot['postId'],
        creatorUid: snapshot['creatorUid'],
        username: snapshot['username'],
        description: snapshot['description'],
        postImageUrl: snapshot['postImageUrl'],
        likes: List.from(snap.get('likes')),
        totalLikes: snapshot['totalLikes'],
        totalComments: snapshot['totalComments'],
        createAt: snapshot['createAt'],
        userProfileUrl: snapshot['userProfileUrl']);
  }

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "creatorUid": creatorUid,
        "username": username,
        "description": description,
        "postImageUrl": postImageUrl,
        "likes": likes,
        "totalLikes": totalLikes,
        "totalComments": totalComments,
        "createAt": createAt,
        "userProfileUrl": userProfileUrl,
      };
}
