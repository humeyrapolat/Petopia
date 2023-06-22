import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:petopia/features/data/data_sources/remote_data_source/remote_data_source.dart';
import 'package:petopia/features/data/models/adoption/adoption_model.dart';
import 'package:petopia/features/data/models/comment/comment_model.dart';
import 'package:petopia/features/data/models/lost/lost_model.dart';
import 'package:petopia/features/data/models/posts/post_model.dart';
import 'package:petopia/features/data/models/replay/replay_model.dart';
import 'package:petopia/features/data/models/animal/animal_model.dart';
import 'package:petopia/features/domain/entities/adoption/adoption_entity.dart';
import 'package:petopia/features/domain/entities/comment/comment_entity.dart';
import 'package:petopia/features/domain/entities/lost/lost_entity.dart';
import 'package:petopia/features/domain/entities/post/post_entity.dart';
import 'package:petopia/features/domain/entities/replay/replay_entity.dart';
import 'package:petopia/features/domain/entities/animal/animal_entity.dart';
import 'package:petopia/util/consts.dart';
import 'package:uuid/uuid.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  FirebaseFirestore firebaseFirestore;
  FirebaseAuth firebaseAuth;
  FirebaseStorage firebaseStorage;

  FirebaseRemoteDataSourceImpl(
      {required this.firebaseFirestore, required this.firebaseAuth, required this.firebaseStorage});

  Future<void> createUserWithImage(AnimalEntity user, String profileUrl) async {
    final userCollection = firebaseFirestore.collection(FirebaseConsts.users);
    final uid = await getCurrentUid();
    userCollection.doc(uid).get().then((userDoc) {
      final newUser = AnimalModel(
        uid: uid,
        name: user.name,
        email: user.email,
        city: user.city,
        district: user.district,
        bio: user.bio,
        following: user.following,
        username: user.username,
        website: user.website,
        profileUrl: profileUrl,
        followers: user.followers,
        favorites: user.favorites,
        type: user.type,
        gender: user.gender,
        breed: user.breed,
        birthdate: user.birthdate,
        likedPosts: user.likedPosts,
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
  Future<void> createUser(AnimalEntity user) async {
    final userCollection = firebaseFirestore.collection(FirebaseConsts.users);

    final uid = await getCurrentUid();

    userCollection.doc(user.uid).get().then((userDoc) {
      final newUser = AnimalModel(
        name: user.name,
        email: user.email,
        city: user.city,
        district: user.district,
        uid: uid,
        bio: user.bio,
        profileUrl: user.profileUrl,
        followers: user.followers,
        following: user.following,
        website: user.website,
        username: user.username,
        type: user.type,
        gender: user.gender,
        breed: user.breed,
        favorites: user.favorites,
        birthdate: user.birthdate,
        likedPosts: user.likedPosts,
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
  Future<String> getCurrentUid() async => firebaseAuth.currentUser!.uid;

  @override
  Stream<List<AnimalEntity>> getSingleUser(String uid) {
    final userCollection = firebaseFirestore.collection(FirebaseConsts.users).where("uid", isEqualTo: uid).limit(1);
    return userCollection.snapshots().map(
      (querySnapsoht) {
        return querySnapsoht.docs.map((e) => AnimalModel.fromSnapshot(e)).toList();
      },
    );
  }

  @override
  Stream<List<AnimalEntity>> getUsers(AnimalEntity user) {
    final userCollection = firebaseFirestore.collection(FirebaseConsts.users);
    return userCollection.snapshots().map(
      (querySnapsoht) {
        return querySnapsoht.docs.map((e) => AnimalModel.fromSnapshot(e)).toList();
      },
    );
  }

  @override
  Future<bool> isSignIn() async => firebaseAuth.currentUser?.uid != null;

  @override
  Future<void> signInUser(AnimalEntity user) async {
    try {
      if (user.email!.isNotEmpty && user.password!.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(email: user.email!, password: user.password!);
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
    await firebaseAuth.signOut();
  }

  @override
  Future<void> passwordReset(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      toast("Error: $e");
    }
  }

  @override
  Future<void> signUpUser(AnimalEntity user) async {
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(email: user.email!, password: user.password!)
          .then((currentUser) async {
        if (currentUser.user?.uid != null) {
          if (user.imageFile != null) {
            uploadImageToStorage(user.imageFile, false, "profileImages").then((profileUrl) {
              createUserWithImage(user, profileUrl);
            });
          } else {
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
  Future<void> updateUser(AnimalEntity user) async {
    final userCollection = firebaseFirestore.collection(FirebaseConsts.users);
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
      userInformation["profileUrl"] = user.profileUrl;
    }
    if (user.favorites != "" && user.favorites != null) {
      userInformation["favorites"] = user.favorites;
    }
    if (user.followers != null) {
      userInformation["followers"] = user.followers;
    }
    if (user.following != null) {
      userInformation["following"] = user.following;
    }
    if (user.likedPosts != null) {
      userInformation["likedPost"] = user.likedPosts;
    }
    if (user.lostPosts != null) {
      userInformation["lostPosts"] = user.lostPosts;
    }
    if (user.adoptionPosts != null) {
      userInformation["adoptionPosts"] = user.adoptionPosts;
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
    if (user.type != null) {
      userInformation["type"] = user.type;
    }
    if (user.gender != null) {
      userInformation["gender"] = user.gender;
    }
    if (user.breed != null) {
      userInformation["breed"] = user.breed;
    }
    if (user.birthdate != null) {
      userInformation["birthdate"] = user.birthdate;
    }

    userCollection.doc(user.uid).update(userInformation);
  }

  @override
  Future<String> uploadImageToStorage(File? file, bool isPost, String childName) async {
    Reference ref = firebaseStorage.ref().child(childName).child(firebaseAuth.currentUser!.uid);
    if (isPost) {
      String id = Uuid().v1();
      ref = ref.child(id);
    }
    final uploadTask = ref.putFile(file!);
    final imageUrl = (await uploadTask.whenComplete(() {})).ref.getDownloadURL();

    return await imageUrl;
  }

  @override
  Future<void> followUnfollowUser(AnimalEntity user) async {
    final userCollection = firebaseFirestore.collection(FirebaseConsts.users);

    final myDocRef = await userCollection.doc(user.uid).get();
    final otherUserDocRef = await userCollection.doc(user.otherUid).get();

    if (myDocRef.exists && otherUserDocRef.exists) {
      List myFollowingList = myDocRef.get("following");
      List otherUserFollowersList = otherUserDocRef.get("followers");

      // My Following List
      if (myFollowingList.contains(user.otherUid)) {
        userCollection.doc(user.uid).update({
          "following": FieldValue.arrayRemove([user.otherUid])
        }).then((value) {
          final userCollection = firebaseFirestore.collection(FirebaseConsts.users).doc(user.uid);

          userCollection.get().then((value) {
            if (value.exists) {
              final totalFollowing = value.get('totalFollowing');
              userCollection.update({"totalFollowing": totalFollowing - 1});
              return;
            }
          });
        });
      } else {
        userCollection.doc(user.uid).update({
          "following": FieldValue.arrayUnion([user.otherUid])
        }).then((value) {
          final userCollection = firebaseFirestore.collection(FirebaseConsts.users).doc(user.uid);

          userCollection.get().then((value) {
            if (value.exists) {
              final totalFollowing = value.get('totalFollowing');
              userCollection.update({"totalFollowing": totalFollowing + 1});
              return;
            }
          });
        });
      }

      // Other User Following List
      if (otherUserFollowersList.contains(user.uid)) {
        userCollection.doc(user.otherUid).update({
          "followers": FieldValue.arrayRemove([user.uid])
        }).then((value) {
          final userCollection = firebaseFirestore.collection(FirebaseConsts.users).doc(user.otherUid);

          userCollection.get().then((value) {
            if (value.exists) {
              final totalFollowers = value.get('totalFollowers');
              userCollection.update({"totalFollowers": totalFollowers - 1});
              return;
            }
          });
        });
      } else {
        userCollection.doc(user.otherUid).update({
          "followers": FieldValue.arrayUnion([user.uid])
        }).then((value) {
          final userCollection = firebaseFirestore.collection(FirebaseConsts.users).doc(user.otherUid);

          userCollection.get().then((value) {
            if (value.exists) {
              final totalFollowers = value.get('totalFollowers');
              userCollection.update({"totalFollowers": totalFollowers + 1});
              return;
            }
          });
        });
      }
    }
  }

  @override
  Stream<List<AnimalEntity>> getSingleOtherUser(String otherUid) {
    final userCollection =
        firebaseFirestore.collection(FirebaseConsts.users).where("uid", isEqualTo: otherUid).limit(1);
    return userCollection
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.map((e) => AnimalModel.fromSnapshot(e)).toList());
  }

  @override
  Future<void> createPost(PostEntity post) async {
    final postCollection = firebaseFirestore.collection(FirebaseConsts.post);

    final newPost = PostModel(
      creatorUid: post.creatorUid,
      postId: post.postId,
      username: post.username,
      userProfileUrl: post.userProfileUrl,
      createAt: post.createAt,
      totalComments: 0,
      totalLikes: 0,
      description: post.description,
      postImageUrl: post.postImageUrl,
      likes: [],
      isPrivate: post.isPrivate!,
    ).toJson();

    try {
      final postDocRef = await postCollection.doc(post.postId).get();

      if (!postDocRef.exists) {
        postCollection.doc(post.postId).set(newPost).then((value) {
          final userCollection = firebaseFirestore.collection(FirebaseConsts.users).doc(post.creatorUid);

          userCollection.get().then((value) {
            if (value.exists) {
              final totalPosts = value.get('totalPosts');
              userCollection.update({"totalPosts": totalPosts + 1});
              return;
            }
          });
        });
      } else {
        postCollection.doc(post.postId).update(newPost);
      }
    } catch (e) {
      toast("some error occured $e ");
    }
  }

  @override
  Future<void> deletePost(PostEntity post) async {
    final postCollection = firebaseFirestore.collection(FirebaseConsts.post);
    final userCollection = firebaseFirestore.collection(FirebaseConsts.users).doc(post.creatorUid);

    try {
      final postDocRef = await postCollection.doc(post.postId).get();
      if (postDocRef.exists) {
        userCollection.get().then((value) {
          if (value.exists) {
            final totalPosts = value.get('totalPosts');
            userCollection.update({"totalPosts": totalPosts - 1});
          }
        }).then((value) => postCollection.doc(post.postId).delete());
      }
    } catch (e) {
      toast("some error occured $e");
    }
  }

  @override
  Future<void> likePost(PostEntity post) async {
    final postCollection = firebaseFirestore.collection(FirebaseConsts.post);
    final userCollection = firebaseFirestore.collection(FirebaseConsts.users);

    final currentUid = await getCurrentUid();
    final postRef = await postCollection.doc(post.postId).get();

    if (postRef.exists) {
      List likes = postRef.get("likes");
      final totalLikes = postRef.get("totalLikes");
      if (likes.contains(currentUid)) {
        postCollection.doc(post.postId).update({
          "likes": FieldValue.arrayRemove([currentUid]),
          "totalLikes": totalLikes - 1
        });

        // burada beğenine aynı zamanda kullanıcının beğendiği postların listesine ekleniyor
        userCollection.doc(currentUid).update({
          "likedPosts": FieldValue.arrayRemove([post.postId])
        });
      } else {
        postCollection.doc(post.postId).update({
          "likes": FieldValue.arrayUnion([currentUid]),
          "totalLikes": totalLikes + 1
        });

        // burada beğenine aynı zamanda kullanıcının beğendiği postların listesine ekleniyor
        userCollection.doc(currentUid).update({
          "likedPosts": FieldValue.arrayUnion([post.postId])
        });
      }
    }
  }

  @override
  Stream<List<PostEntity>> readPost(PostEntity post) {
    final postCollection = firebaseFirestore.collection(FirebaseConsts.post).orderBy("createAt", descending: true);
    return postCollection
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.map((e) => PostModel.fromSnapshot(e)).toList());
  }

  @override
  Stream<List<PostEntity>> readSinglePost(String postId) {
    final postCollection = firebaseFirestore
        .collection(FirebaseConsts.post)
        .orderBy("createAt", descending: true)
        .where("postId", isEqualTo: postId);
    return postCollection
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.map((e) => PostModel.fromSnapshot(e)).toList());
  }

  @override
  Future<void> updatePost(PostEntity post) async {
    final postCollection = firebaseFirestore.collection(FirebaseConsts.post);
    Map<String, dynamic> postInfo = Map();

    if (post.description != "" && post.description != null) {
      postInfo['description'] = post.description;
    }
    if (post.postImageUrl != "" && post.postImageUrl != null) {
      postInfo['postImageUrl'] = post.postImageUrl;
    }
    postCollection.doc(post.postId).update(postInfo);
  }

  @override
  Future<void> createComment(CommentEntity comment) async {
    final commentCollection =
        firebaseFirestore.collection(FirebaseConsts.post).doc(comment.postId).collection(FirebaseConsts.comments);

    final newComment = CommentModel(
            userProfileUrl: comment.userProfileUrl,
            username: comment.username,
            totalReplays: comment.totalReplays,
            commentId: comment.commentId,
            postId: comment.postId,
            likes: [],
            description: comment.description,
            creatorUid: comment.creatorUid,
            createAt: comment.createAt)
        .toJson();

    try {
      final commentDocRef = await commentCollection.doc(comment.commentId).get();

      if (!commentDocRef.exists) {
        commentCollection.doc(comment.commentId).set(newComment).then((value) {
          final postCollection = firebaseFirestore.collection(FirebaseConsts.post).doc(comment.postId);

          postCollection.get().then((value) {
            if (value.exists) {
              final totalComments = value.get('totalComments');
              postCollection.update({"totalComments": totalComments + 1});
              return;
            }
          });
        });
      } else {
        commentCollection.doc(comment.commentId).update(newComment);
      }
    } catch (e) {
      print("some error occured $e");
    }
  }

  @override
  Future<void> deleteComment(CommentEntity comment) async {
    final commentCollection =
        firebaseFirestore.collection(FirebaseConsts.post).doc(comment.postId).collection(FirebaseConsts.comments);

    try {
      commentCollection.doc(comment.commentId).delete().then((value) {
        final postCollection = firebaseFirestore.collection(FirebaseConsts.post).doc(comment.postId);

        postCollection.get().then((value) {
          if (value.exists) {
            final totalComments = value.get('totalComments');
            postCollection.update({"totalComments": totalComments - 1});
            return;
          }
        });
      });
    } catch (e) {
      toast("some error occured $e");
    }
  }

  @override
  Future<void> likeComment(CommentEntity comment) async {
    final commentCollection =
        firebaseFirestore.collection(FirebaseConsts.post).doc(comment.postId).collection(FirebaseConsts.comments);
    final currentUid = await getCurrentUid();

    final commentRef = await commentCollection.doc(comment.commentId).get();

    if (commentRef.exists) {
      List likes = commentRef.get("likes");
      if (likes.contains(currentUid)) {
        commentCollection.doc(comment.commentId).update({
          "likes": FieldValue.arrayRemove([currentUid])
        });
      } else {
        commentCollection.doc(comment.commentId).update({
          "likes": FieldValue.arrayUnion([currentUid])
        });
      }
    }
  }

  @override
  Stream<List<CommentEntity>> readComments(String postId) {
    final commentCollection = firebaseFirestore
        .collection(FirebaseConsts.post)
        .doc(postId)
        .collection(FirebaseConsts.comments)
        .orderBy("createAt", descending: true);
    return commentCollection
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.map((e) => CommentModel.fromSnapshot(e)).toList());
  }

  @override
  Future<void> updateComment(CommentEntity comment) async {
    final commentCollection =
        firebaseFirestore.collection(FirebaseConsts.post).doc(comment.postId).collection(FirebaseConsts.comments);

    Map<String, dynamic> commentInfo = Map();

    if (comment.description != "" && comment.description != null) commentInfo["description"] = comment.description;

    commentCollection.doc(comment.commentId).update(commentInfo);
  }

  @override
  Future<void> createReplay(ReplayEntity replay) async {
    final replayCollection = firebaseFirestore
        .collection(FirebaseConsts.post)
        .doc(replay.postId)
        .collection(FirebaseConsts.comments)
        .doc(replay.commentId)
        .collection(FirebaseConsts.replay);

    final newReplay = ReplayModel(
            userProfileUrl: replay.userProfileUrl,
            username: replay.username,
            replayId: replay.replayId,
            commentId: replay.commentId,
            postId: replay.postId,
            likes: [],
            description: replay.description,
            creatorUid: replay.creatorUid,
            createAt: replay.createAt)
        .toJson();

    try {
      final replayDocRef = await replayCollection.doc(replay.replayId).get();

      if (!replayDocRef.exists) {
        replayCollection.doc(replay.replayId).set(newReplay).then((value) {
          final commentCollection = firebaseFirestore
              .collection(FirebaseConsts.post)
              .doc(replay.postId)
              .collection(FirebaseConsts.comments)
              .doc(replay.commentId);

          commentCollection.get().then((value) {
            if (value.exists) {
              final totalReplays = value.get('totalReplays');
              commentCollection.update({"totalRep lays": totalReplays + 1});
              return;
            }
          });
        });
      } else {
        replayCollection.doc(replay.replayId).update(newReplay);
      }
    } catch (e) {
      print("some error occured $e");
    }
  }

  @override
  Future<void> deleteReplay(ReplayEntity replay) async {
    final replayCollection = firebaseFirestore
        .collection(FirebaseConsts.post)
        .doc(replay.postId)
        .collection(FirebaseConsts.comments)
        .doc(replay.commentId)
        .collection(FirebaseConsts.replay);

    try {
      replayCollection.doc(replay.replayId).delete().then((value) {
        final commentCollection = firebaseFirestore
            .collection(FirebaseConsts.post)
            .doc(replay.postId)
            .collection(FirebaseConsts.comments)
            .doc(replay.commentId);

        commentCollection.get().then((value) {
          if (value.exists) {
            final totalReplays = value.get('totalReplays');
            commentCollection.update({"totalReplays": totalReplays - 1});
            return;
          }
        });
      });
    } catch (e) {
      print("some error occured $e");
    }
  }

  @override
  Future<void> likeReplay(ReplayEntity replay) async {
    final replayCollection = firebaseFirestore
        .collection(FirebaseConsts.post)
        .doc(replay.postId)
        .collection(FirebaseConsts.comments)
        .doc(replay.commentId)
        .collection(FirebaseConsts.replay);

    final currentUid = await getCurrentUid();

    final replayRef = await replayCollection.doc(replay.replayId).get();

    if (replayRef.exists) {
      List likes = replayRef.get("likes");
      if (likes.contains(currentUid)) {
        replayCollection.doc(replay.replayId).update({
          "likes": FieldValue.arrayRemove([currentUid])
        });
      } else {
        replayCollection.doc(replay.replayId).update({
          "likes": FieldValue.arrayUnion([currentUid])
        });
      }
    }
  }

  @override
  Stream<List<ReplayEntity>> readReplays(ReplayEntity replay) {
    final replayCollection = firebaseFirestore
        .collection(FirebaseConsts.post)
        .doc(replay.postId)
        .collection(FirebaseConsts.comments)
        .doc(replay.commentId)
        .collection(FirebaseConsts.replay);
    return replayCollection
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.map((e) => ReplayModel.fromSnapshot(e)).toList());
  }

  @override
  Future<void> updateReplay(ReplayEntity replay) async {
    final replayCollection = firebaseFirestore
        .collection(FirebaseConsts.post)
        .doc(replay.postId)
        .collection(FirebaseConsts.comments)
        .doc(replay.commentId)
        .collection(FirebaseConsts.replay);

    Map<String, dynamic> replayInfo = Map();

    if (replay.description != "" && replay.description != null) replayInfo['description'] = replay.description;

    replayCollection.doc(replay.replayId).update(replayInfo);
  }

  @override
  Future<void> createAdoption(AdoptionEntity adoption) async {
    final adoptionCollection = firebaseFirestore.collection(FirebaseConsts.adoption);

    final newAdoption = AdoptionModel(
      creatorUid: adoption.creatorUid,
      city: adoption.city,
      type: adoption.type,
      age: adoption.age,
      adoptionPostId: adoption.adoptionPostId,
      profileUrl: adoption.profileUrl,
    ).toJson();

    try {
      final adoptinDocRef = await adoptionCollection.doc(adoption.adoptionPostId).get();

      if (!adoptinDocRef.exists) {
        adoptionCollection.doc(adoption.adoptionPostId).set(newAdoption).then((value) {});
      } else {
        adoptionCollection.doc(adoption.adoptionPostId).update(newAdoption);
      }
    } catch (e) {
      toast("some error occured $e ");
    }
  }

  @override
  Future<void> deleteAdoption(AdoptionEntity adoption) async {
    final adoptionCollection = firebaseFirestore.collection(FirebaseConsts.adoption);

    try {
      final adoptinDocRef = await adoptionCollection.doc(adoption.adoptionPostId).get();
      if (adoptinDocRef.exists) {
        adoptionCollection.doc(adoption.adoptionPostId).delete();
      }
    } catch (e) {
      toast("some error occured $e");
    }
  }

  @override
  Future<void> likeAdoption(AdoptionEntity adoption) async {
    /* final adoptionCollection = firebaseFirestore.collection(FirebaseConsts.adoption);

    final currentUid = await getCurrentUid();
    final adoptionRef = await adoptionCollection.doc(adoption.adoptionPostId).get();

    if (adoptionRef.exists) {
      List likes = adoptionRef.get("likes");
      } else {
        postCollection.doc(post.postId).update({
          "likes": FieldValue.arrayUnion([currentUid]),
          "totalLikes": totalLikes + 1
        });
      }
    }*/
  }

  @override
  Stream<List<AdoptionEntity>> readAdoption(AdoptionEntity adoption) {
    final adoptionCollection = firebaseFirestore.collection(FirebaseConsts.adoption);

    return adoptionCollection
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.map((e) => AdoptionModel.fromSnapshot(e)).toList());
  }

  @override
  Stream<List<AdoptionEntity>> readSingleAdoption(String adoptionId) {
    final adoptionCollection = firebaseFirestore
        .collection(FirebaseConsts.adoption)
        .orderBy("createAt", descending: true)
        .orderBy("createAt", descending: true)
        .where("postId", isEqualTo: adoptionId);
    return adoptionCollection
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.map((e) => AdoptionModel.fromSnapshot(e)).toList());
  }

  @override
  Future<void> updateAdoption(AdoptionEntity adoption) {
    // TODO: implement updateAdoption
    throw UnimplementedError();
  }

  @override
  Future<void> createLost(LostEntity lost) async {
    final lostCollection = firebaseFirestore.collection(FirebaseConsts.lost);
    final userCollection = firebaseFirestore.collection(FirebaseConsts.users);
    final currentUid = await getCurrentUid();

    final newLost = LostModel(
      creatorUid: lost.creatorUid,
      city: lost.city,
      lostAnimalId: lost.lostAnimalId,
      imageUrl: lost.imageUrl,
      date: DateTime.now(),
      district: lost.district,
      isWithMe: lost.isWithMe,
      description: lost.description,
      isinjured: lost.isinjured,
    ).toJson();

    try {
      final lostDocRef = await lostCollection.doc(lost.lostAnimalId).get();

      if (!lostDocRef.exists) {
        lostCollection.doc(lost.lostAnimalId).set(newLost).then((value) {
          userCollection.doc(currentUid).update({
            "lostPosts": FieldValue.arrayUnion([lost.imageUrl])
          });
        });
      } else {
        lostCollection.doc(lost.lostAnimalId).update(newLost).then((value) {});
      }
    } catch (e) {
      toast("some error occured $e ");
    }
  }

  @override
  Future<void> deleteLost(LostEntity lost) async {
    final lostCollection = firebaseFirestore.collection(FirebaseConsts.lost);
    final userCollection = firebaseFirestore.collection(FirebaseConsts.users);
    final currentUid = await getCurrentUid();

    try {
      final adoptinDocRef = await lostCollection.doc(lost.lostAnimalId).get();
      if (adoptinDocRef.exists) {
        lostCollection.doc(lost.lostAnimalId).delete().then((value) {
          userCollection.doc(currentUid).update({
            "lostPosts": FieldValue.arrayRemove([lost.imageUrl])
          });
        });
      }
    } catch (e) {
      toast("some error occured $e");
    }
  }

  @override
  Stream<List<LostEntity>> readLost(LostEntity lost) {
    final lostCollection = firebaseFirestore.collection(FirebaseConsts.lost);

    return lostCollection
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.map((e) => LostModel.fromSnapshot(e)).toList());
  }

  @override
  Stream<List<LostEntity>> readSingleLost(String adoptionId) {
    // TODO: implement readSingleLost
    throw UnimplementedError();
  }

  @override
  Future<void> updateLost(LostEntity adoption) {
    // TODO: implement updateLost
    throw UnimplementedError();
  }

  @override
  Future<bool> getFavUsers(AnimalEntity user) async {
    final userCollection = firebaseFirestore.collection(FirebaseConsts.users);
    await userCollection.doc(user.uid).update({
      "favorites": FieldValue.arrayUnion([user.otherUid])
    });
    return true;
  }

  @override
  Stream<List<AnimalEntity>> getOtherUsers(String userId) {
    final userCollection = firebaseFirestore.collection(FirebaseConsts.users);
    return userCollection.snapshots().map(
      (querySnapshot) {
        return querySnapshot.docs
            .where((doc) => doc.id != userId) // Benim UID'me sahip olan dökümanı filtrele
            .map((doc) => AnimalModel.fromSnapshot(doc))
            .toList();
      },
    );
  }
}
