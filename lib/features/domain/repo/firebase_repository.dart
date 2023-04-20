import 'dart:io';

import 'package:petopia/features/domain/entities/comment/comment_entity.dart';
import 'package:petopia/features/domain/entities/post/post_entity.dart';
import 'package:petopia/features/domain/entities/user/user_entity.dart';

abstract class FirebaseRepository {
  //Credential
  Future<void> signInUser(UserEntity user);
  Future<void> signUpUser(UserEntity user);
  Future<bool> isSignIn();
  Future<void> signOut();
  Future<void> passwordReset(String email);


  //User
  Stream<List<UserEntity>> getUsers(UserEntity user); //canli veriler olacagi icin Stream kullaniyoz
  Stream<List<UserEntity>> getSingleUsers(String uid);
  Future<String> getCurrentUid();
  Future<void> createUser(UserEntity user);
  Future<void> updateUser(UserEntity user);

  //Cloud Storage
  Future<String> uploadImageToStorage(File? file, bool isPost, String childName);

  //Post
  Future<void> createPost(PostEntity post);
  Stream<List<PostEntity>> readPost(PostEntity post);
  Future<void> updatePost(PostEntity post);
  Future<void> deletePost(PostEntity post);
  Future<void> likePost(PostEntity post);

  //Comments
  Future<void> createComment(CommentEntity comment);
  Stream<List<CommentEntity>> readComments(String postId);
  Future<void> updateComment(CommentEntity comment);
  Future<void> deleteComment(CommentEntity comment);
  Future<void> likeComment(CommentEntity comment);
}
