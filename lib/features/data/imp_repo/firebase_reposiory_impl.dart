import 'dart:io';

import 'package:petopia/features/data/data_sources/remote_data_source/remote_data_source.dart';
import 'package:petopia/features/domain/entities/user/user_entity.dart';
import 'package:petopia/features/domain/repo/firebase_repository.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final FirebaseRemoteDataSource remoteDataSource;

  FirebaseRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> createUser(UserEntity user) async =>
      await remoteDataSource.createUser(user);

  @override
  Future<String> getCurrentUid() async =>
      await remoteDataSource.getCurrentUid();

  @override
  Stream<List<UserEntity>> getUsers(UserEntity user) =>
      remoteDataSource.getUsers(user);

  @override
  Future<bool> isSignIn() async => await remoteDataSource.isSignIn();

  @override
  Future<void> signInUser(UserEntity user) async =>
      await remoteDataSource.signInUser(user);

  @override
  Future<void> signOut() async => await remoteDataSource.signOut();

  @override
  Future<void> signUpUser(UserEntity user) async =>
      await remoteDataSource.signUpUser(user);

  @override
  Future<void> updateUser(UserEntity user) async =>
      await remoteDataSource.updateUser(user);

  @override
  Stream<List<UserEntity>> getSingleUsers(String uid) =>
      remoteDataSource.getSingleUser(uid);

  @override
  Future<String> uploadImageToStorage(File? file, bool isPost, String childName) async =>
      remoteDataSource.uploadImageToStorage(file, isPost, childName);

}
