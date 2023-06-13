import 'dart:io';

import 'package:petopia/features/domain/entities/comment/comment_entity.dart';
import 'package:petopia/features/domain/entities/post/post_entity.dart';
import 'package:petopia/features/domain/entities/replay/replay_entity.dart';
import 'package:petopia/features/domain/entities/animal/animal_entity.dart';

abstract class FirebaseRepository {
  //Credential
  Future<void> signInUser(AnimalEntity user);
  Future<void> signUpUser(AnimalEntity user);
  Future<bool> isSignIn();
  Future<void> signOut();
  Future<void> passwordReset(String email);

  //User
  Stream<List<AnimalEntity>> getUsers(
      AnimalEntity user); //canli veriler olacagi icin Stream kullaniyoz
  Stream<List<AnimalEntity>> getSingleUsers(String uid);
  Stream<List<AnimalEntity>> getSingleOtherUser(String otherUid);
  Future<String> getCurrentUid();
  Future<void> createUser(AnimalEntity user);
  Future<void> updateUser(AnimalEntity user);
  Future<void> followUnfollowUser(AnimalEntity user);
  // Match
  Future<void> getFavUsers(AnimalEntity user);

  //Cloud Storage
  Future<String> uploadImageToStorage(
      File? file, bool isPost, String childName);

  //Post
  Future<void> createPost(PostEntity post);
  Stream<List<PostEntity>> readPost(PostEntity post);
  Stream<List<PostEntity>> readSinglePost(String postId);
  Future<void> updatePost(PostEntity post);
  Future<void> deletePost(PostEntity post);
  Future<void> likePost(PostEntity post);

  //Comments
  Future<void> createComment(CommentEntity comment);
  Stream<List<CommentEntity>> readComments(String postId);
  Future<void> updateComment(CommentEntity comment);
  Future<void> deleteComment(CommentEntity comment);
  Future<void> likeComment(CommentEntity comment);

  // Replay Features
  Future<void> createReplay(ReplayEntity replay);
  Stream<List<ReplayEntity>> readReplays(ReplayEntity replay);
  Future<void> updateReplay(ReplayEntity replay);
  Future<void> deleteReplay(ReplayEntity replay);
  Future<void> likeReplay(ReplayEntity replay);
}
