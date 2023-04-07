import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:petopia/features/data/data_sources/remote_data_source/remote_data_source.dart';
import 'package:petopia/features/data/models/user/user_model.dart';
import 'package:petopia/features/domain/entities/user/user_entity.dart';
import 'package:petopia/util/consts.dart';
import 'package:uuid/uuid.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  FirebaseFirestore firestore;
  FirebaseAuth auth;
  FirebaseStorage firebaseStorage;

  FirebaseRemoteDataSourceImpl({ required this.firestore, required this.auth, required this.firebaseStorage});

  @override
  Future<void> createUserWithImage(UserEntity user, String profileUrl) async {
    final userCollection = firestore.collection(FirebaseConsts.users);
    final uid = await getCurrentUid();
    userCollection.doc(uid).get().then((userDoc){
      final newUser = UserModel(
        uid: uid,
        name: user.name,
        email: user.email,
        bio: user.bio,
        following: user.following,
        username: user.username,
        website: user.website,
        profileUrl: profileUrl,
        followers: user.followers,
        totalFollowers: user.totalFollowers,
        totalFollowing: user.totalFollowing,
        totalPosts: user.totalPosts,
      ).toJson();

      if (!userDoc.exists) {
        userCollection.doc(uid).set(newUser);
      } else {
        userCollection.doc(uid).update(newUser);
      }
    }).catchError((error) {
      toast("Some error occur");
    });
  }

  @override
  Future<void> createUser(UserEntity user) async {
    final userCollection = firestore.collection(FirebaseConsts.users);

    final uid = await getCurrentUid();

    userCollection.doc(user.uid).get().then((userDoc) {
      final newUser = UserModel(
        name: user.name,
        email: user.email,
        uid: uid,
        bio: user.bio,
        profileUrl: user.profileUrl,
        followers: user.followers,
        following: user.following,
        website: user.website,
        username: user.username,
        totalFollowers: user.totalFollowers,
        totalFollowing: user.totalFollowing,
        totalPosts: user.totalPosts,
      ).toJson();

      if (!userDoc.exists) {
        userCollection.doc(uid).set(newUser);
      } else {
        userCollection.doc(uid).update(newUser);
      }
    }).catchError((error) {
      toast("Error: $error");
    });
  }

  @override
  Future<String> getCurrentUid() async => auth.currentUser!.uid;

  @override
  Stream<List<UserEntity>> getSingleUser(String uid) {
    final userCollection = firestore
        .collection(FirebaseConsts.users)
        .where("uid", isEqualTo: uid)
        .limit(1);
    return userCollection.snapshots().map(
      (querySnapsoht) {
        return querySnapsoht.docs
            .map((e) => UserModel.fromSnapshot(e))
            .toList();
      },
    );
  }

  @override
  Stream<List<UserEntity>> getUsers(UserEntity user) {
    final userCollection = firestore.collection(FirebaseConsts.users);
    return userCollection.snapshots().map(
      (querySnapsoht) {
        return querySnapsoht.docs
            .map((e) => UserModel.fromSnapshot(e))
            .toList();
      },
    );
  }

  @override
  Future<bool> isSignIn() async => auth.currentUser?.uid != null;

  @override
  Future<void> signInUser(UserEntity user) async {
    try {
      if (user.email!.isNotEmpty && user.password!.isNotEmpty) {
        await auth.signInWithEmailAndPassword(
            email: user.email!, password: user.password!);
      } else {
        print("Email and password can't be empty");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        toast("No user found for that email");
      } else if (e.code == "wrong-password") {
        toast("Wrong password provided for that user");
      }
    }
  }

  @override
  Future<void> signOut() async {
    await auth.signOut();
  }

  @override
  Future<void> signUpUser(UserEntity user) async {
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: user.email!, password: user.password!)
          .then((currentUser) async {
        if (currentUser.user?.uid != null) {
          if(user.imageFile != null){
            uploadImageToStorage(user.imageFile, false, "profileImages").then((profileUrl){
              createUserWithImage(user, profileUrl);
            });
          }else{
            createUserWithImage(user, "");
          }
        }
      });
      return;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        toast("The account already exists for that email");
      } else if (e.code == "something-went-wrong") {
        toast("Something went wrong");
      }
    }
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    final userCollection = firestore.collection(FirebaseConsts.users);
    Map<String, dynamic> userInformation = {};

    if (user.username != "" && user.username != null) {
      userInformation["username"] = user.username;
    }
    if (user.name != "" && user.name != null) {
      userInformation["name"] = user.name;
    }
    if (user.bio != "" && user.bio != null) {
      userInformation["bio"] = user.bio;
    }
    if (user.website != "" && user.website != null) {
      userInformation["website"] = user.website;
    }
    if (user.profileUrl != "" && user.profileUrl != null) {
      userInformation["profileImageUrl"] = user.profileUrl;
    }
    if (user.followers != null) {
      userInformation["followers"] = user.followers;
    }
    if (user.following != null) {
      userInformation["following"] = user.following;
    }
    if (user.totalFollowers != null) {
      userInformation["totalFollowers"] = user.totalFollowers;
    }
    if (user.totalFollowing != null) {
      userInformation["totalFollowing"] = user.totalFollowing;
    }
    if (user.totalPosts != null) {
      userInformation["totalPosts"] = user.totalPosts;
    }

    userCollection.doc(user.uid).update(userInformation);
  }

  @override
  Future<String> uploadImageToStorage(File? file, bool isPost, String childName) async {
    Reference ref = firebaseStorage.ref().child(childName).child(auth.currentUser!.uid);
    if(isPost){
      String id = Uuid().v1();
      ref = ref.child(id);
    }
    final uploadTask = ref.putFile(file!);
    final imageUrl = (await uploadTask.whenComplete((){})).ref.getDownloadURL();

    return await imageUrl;
  }
}
