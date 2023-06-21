import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:petopia/features/data/data_sources/remote_data_source/remote_data_source.dart';
import 'package:petopia/features/domain/entities/adoption/adoption_entity.dart';
import 'package:petopia/features/domain/entities/comment/comment_entity.dart';
import 'package:petopia/features/domain/entities/lost/lost_entity.dart';
import 'package:petopia/features/domain/entities/post/post_entity.dart';
import 'package:petopia/features/domain/entities/replay/replay_entity.dart';
import 'package:petopia/features/domain/entities/animal/animal_entity.dart';
import 'package:petopia/features/domain/repo/firebase_repository.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final FirebaseRemoteDataSource remoteDataSource;

  FirebaseRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> createUser(AnimalEntity user) async => await remoteDataSource.createUser(user);

  @override
  Future<String> getCurrentUid() async => await remoteDataSource.getCurrentUid();

  @override
  Stream<List<AnimalEntity>> getUsers(AnimalEntity user) => remoteDataSource.getUsers(user);

  Stream<List<AnimalEntity>> getOtherUsers(String userId) => remoteDataSource.getOtherUsers(userId);

  @override
  Future<bool> isSignIn() async => await remoteDataSource.isSignIn();

  @override
  Future<void> signInUser(AnimalEntity user) async => await remoteDataSource.signInUser(user);

  @override
  Future<void> signOut() async => await remoteDataSource.signOut();

  @override
  Future<void> passwordReset(String email) async => await remoteDataSource.passwordReset(email);

  @override
  Future<void> signUpUser(AnimalEntity user) async => await remoteDataSource.signUpUser(user);

  @override
  Future<void> updateUser(AnimalEntity user) async => await remoteDataSource.updateUser(user);

  @override
  Stream<List<AnimalEntity>> getSingleUsers(String uid) => remoteDataSource.getSingleUser(uid);

  @override
  Future<String> uploadImageToStorage(File? file, bool isPost, String childName) async =>
      remoteDataSource.uploadImageToStorage(file, isPost, childName);

  @override
  Future<void> createPost(PostEntity post) async => remoteDataSource.createPost(post);

  @override
  Future<void> deletePost(PostEntity post) async => remoteDataSource.deletePost(post);

  @override
  Future<void> likePost(PostEntity post) async => remoteDataSource.likePost(post);

  @override
  Stream<List<PostEntity>> readPost(PostEntity post) => remoteDataSource.readPost(post);

  @override
  Stream<List<PostEntity>> readSinglePost(String postId) => remoteDataSource.readSinglePost(postId);

  @override
  Future<void> updatePost(PostEntity post) async => remoteDataSource.updatePost(post);

  @override
  Future<void> createComment(CommentEntity comment) async => remoteDataSource.createComment(comment);

  @override
  Future<void> deleteComment(CommentEntity comment) async => remoteDataSource.deleteComment(comment);

  @override
  Future<void> likeComment(CommentEntity comment) async => remoteDataSource.likeComment(comment);

  @override
  Stream<List<CommentEntity>> readComments(String postId) => remoteDataSource.readComments(postId);

  @override
  Future<void> updateComment(CommentEntity comment) async => remoteDataSource.updateComment(comment);

  @override
  Future<void> createReplay(ReplayEntity replay) async => remoteDataSource.createReplay(replay);

  @override
  Future<void> deleteReplay(ReplayEntity replay) async => remoteDataSource.deleteReplay(replay);

  @override
  Future<void> likeReplay(ReplayEntity replay) async => remoteDataSource.likeReplay(replay);

  @override
  Stream<List<ReplayEntity>> readReplays(ReplayEntity replay) => remoteDataSource.readReplays(replay);

  @override
  Future<void> updateReplay(ReplayEntity replay) async => remoteDataSource.updateReplay(replay);

  @override
  Future<void> followUnfollowUser(AnimalEntity user) async => remoteDataSource.followUnfollowUser(user);

  @override
  Stream<List<AnimalEntity>> getSingleOtherUser(String otherUid) => remoteDataSource.getSingleOtherUser(otherUid);

  @override
  Future<bool> getFavUsers(AnimalEntity user) async => remoteDataSource.getFavUsers(user);

  @override
  Future<void> createAdoption(AdoptionEntity adoption) async => remoteDataSource.createAdoption(adoption);

  @override
  Future<void> deleteAdoption(AdoptionEntity adoption) async => remoteDataSource.deleteAdoption(adoption);

  @override
  Future<void> likeAdoption(AdoptionEntity adoption) async => remoteDataSource.likeAdoption(adoption);

  @override
  Stream<List<AdoptionEntity>> readAdoption(AdoptionEntity adoption) => remoteDataSource.readAdoption(adoption);

  @override
  Stream<List<AdoptionEntity>> readSingleAdoption(String adoptionId) => remoteDataSource.readSingleAdoption(adoptionId);

  @override
  Future<void> updateAdoption(AdoptionEntity adoption) async => remoteDataSource.updateAdoption(adoption);

  @override
  Future<void> createLost(LostEntity lost) async => remoteDataSource.createLost(lost);

  @override
  Future<void> deleteLost(LostEntity lost) async => remoteDataSource.deleteLost(lost);

  @override
  Stream<List<LostEntity>> readLost(LostEntity lost) => remoteDataSource.readLost(lost);

  @override
  Stream<List<LostEntity>> readSingleLost(String lostId) => remoteDataSource.readSingleLost(lostId);

  @override
  Future<void> updateLost(LostEntity lost) async => remoteDataSource.updateLost(lost);
}
