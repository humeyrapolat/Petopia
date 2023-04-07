import 'dart:io';

import 'package:petopia/features/domain/entities/user/user_entity.dart';

abstract class FirebaseRepository {
  //Credential
  Future<void> signInUser(UserEntity user);
  Future<void> signUpUser(UserEntity user);
  Future<bool> isSignIn();
  Future<void> signOut();

  //User
  Stream<List<UserEntity>> getUsers(UserEntity user); //canli veriler olacagi icin Stream kullaniyoz
  Stream<List<UserEntity>> getSingleUsers(String uid);
  Future<String> getCurrentUid();
  Future<void> createUser(UserEntity user);
  Future<void> updateUser(UserEntity user);

  //Cloud Storage
  Future<String> uploadImageToStorage(File? file, bool isPost, String childName);
}
