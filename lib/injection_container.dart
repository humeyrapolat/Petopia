import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:petopia/features/data/data_sources/remote_data_source/remote_data_source.dart';
import 'package:petopia/features/data/data_sources/remote_data_source/remote_data_source_imlp.dart';
import 'package:petopia/features/data/imp_repo/firebase_reposiory_impl.dart';
import 'package:petopia/features/domain/repo/firebase_repository.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/adoption/create_adoption_usecase.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/adoption/delete_adoption_usecase.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/adoption/read_adoption_usecase.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/comment/create_comment_usecase.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/comment/delete_comment_usecase.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/comment/like_comment_usecase.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/comment/read_comment_usecase.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/comment/update_comment_usecase.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/lost/create_lost_usecase.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/lost/delete_lost_usecase.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/lost/read_lost_usecase.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/replay/read_replay_usecase.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/resetPassword/reset_password_usecase.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/storage/upload_image_to_storage_usecase.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/user/create_user_usecase.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/user/get_current_uid_usecase.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/user/get_fav_user_usecase.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/user/get_other_user_usecase.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/user/get_single_user_usecase.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/user/get_users_usecase.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/user/is_sign_in_usecase.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/user/sign_in_user_usecase.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/user/sign_out_usecase.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/user/sign_up_user_usecase.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/user/update_user_usecase.dart';
import 'package:petopia/features/presentation/cubit/adoption/adoption_cubit.dart';
import 'package:petopia/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:petopia/features/presentation/cubit/comment/comment_cubit.dart';
import 'package:petopia/features/presentation/cubit/credential/credential_cubit.dart';
import 'package:petopia/features/presentation/cubit/lost/lost_cubit.dart';
import 'package:petopia/features/presentation/cubit/resetPassword/reset_password_cubit.dart';
import 'package:petopia/features/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:petopia/features/presentation/cubit/user/user_cubit.dart';
import 'features/domain/usecases/firebase_usecases/post/create_post_usecase.dart';
import 'features/domain/usecases/firebase_usecases/post/delete_post_usecase.dart';
import 'features/domain/usecases/firebase_usecases/post/like_post_usecase.dart';
import 'features/domain/usecases/firebase_usecases/post/read_post_usecase.dart';
import 'features/domain/usecases/firebase_usecases/post/read_single_post_usecase.dart';
import 'features/domain/usecases/firebase_usecases/post/update_post_usecase.dart';
import 'features/domain/usecases/firebase_usecases/replay/create_replay_usecase.dart';
import 'features/domain/usecases/firebase_usecases/replay/delete_replay_usecase.dart';
import 'features/domain/usecases/firebase_usecases/replay/like_replay_usecase.dart';
import 'features/domain/usecases/firebase_usecases/replay/update_replay_usecase.dart';
import 'features/domain/usecases/firebase_usecases/user/follow_unfollow_user_usecase.dart';
import 'features/domain/usecases/firebase_usecases/user/get_single_other_user_usecase.dart';
import 'features/presentation/cubit/post/get_single_post/get_single_post_cubit.dart';
import 'features/presentation/cubit/post/post_cubit.dart';
import 'features/presentation/cubit/replay/replay_cubit.dart';
import 'features/presentation/cubit/user/get_single_other_user/get_single_other_user_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubits
  sl.registerFactory(
    () => AuthCubit(
      signOutUseCase: sl.call(),
      isSignInUseCase: sl.call(),
      getCurrentUidUseCase: sl.call(),
    ),
  );

  sl.registerFactory(
    () => CredentialCubit(
      signUpUserUseCase: sl.call(),
      signInUserUseCase: sl.call(),
    ),
  );

  sl.registerFactory(
    () => UserCubit(
        updateUserUseCase: sl.call(),
        getUsersUseCase: sl.call(),
        followUnfollowUseCase: sl.call(),
        getOtherUsersUseCase: sl.call(),
        getFavUsersUseCase: sl.call()),
  );

  sl.registerFactory(
    () => GetSingleOtherUserCubit(getSingleOtherUserUseCase: sl.call()),
  );

  sl.registerFactory(
    () => GetSingleUserCubit(
      getSingleUserUseCase: sl.call(),
    ),
  );

  sl.registerFactory(
    () => ResetPasswordCubit(
      resetPasswordUseCase: sl.call(),
    ),
  );

  // Post Cubit Injection
  sl.registerFactory(
    () => PostCubit(
        updatePostUseCase: sl.call(),
        deletePostUseCase: sl.call(),
        likePostUseCase: sl.call(),
        createPostUseCase: sl.call(),
        readPostUseCase: sl.call()),
  );

  sl.registerFactory(
    () => GetSinglePostCubit(readSinglePostUseCase: sl.call()),
  );

  // Comment Cubit Injection
  sl.registerFactory(
    () => CommentCubit(
      updateCommentUseCase: sl.call(),
      readCommentsUseCase: sl.call(),
      likeCommentUseCase: sl.call(),
      deleteCommentUseCase: sl.call(),
      createCommentUseCase: sl.call(),
    ),
  );

  // Replay Cubit Injection
  sl.registerFactory(
    () => ReplayCubit(
        createReplayUseCase: sl.call(),
        deleteReplayUseCase: sl.call(),
        likeReplayUseCase: sl.call(),
        readReplaysUseCase: sl.call(),
        updateReplayUseCase: sl.call()),
  );

  sl.registerFactory(
    () => AdoptionCubit(
      createAdoptionUseCase: sl.call(),
      deleteAdoptionUseCase: sl.call(),
      readAdoptionUseCase: sl.call(),
    ),
  );

  sl.registerFactory(
    () => LostCubit(
      createLostUseCase: sl.call(),
      deleteLostUseCase: sl.call(),
      readLostUseCase: sl.call(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => SignOutUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => IsSignInUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetCurrentUidUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => SignUpUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => SignInUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => UpdateUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetUsersUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => CreateUserUserCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetSingleUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => ReadSinglePostUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => FollowUnfollowUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetSingleOtherUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetOtherUsersUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetFavUsersUseCase(repository: sl.call()));

  //Cloud Storage
  sl.registerLazySingleton(() => UploadImageToStorageUseCase(repository: sl.call()));

  //Post
  sl.registerLazySingleton(() => CreatePostUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => ReadPostUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => LikePostUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => DeletePostUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => UpdatePostUseCase(repository: sl.call()));

  //Comment
  sl.registerLazySingleton(() => CreateCommentUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => ReadCommentUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => LikeCommentUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => DeleteCommentUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => UpdateCommentUseCase(repository: sl.call()));

  // Replay
  sl.registerLazySingleton(() => CreateReplayUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => ReadReplaysUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => LikeReplayUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => UpdateReplayUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => DeleteReplayUseCase(repository: sl.call()));

  // Adoption
  sl.registerFactory(() => CreateAdoptionUseCase(repository: sl.call()));
  sl.registerFactory(() => DeleteAdoptionUseCase(repository: sl.call()));
  sl.registerFactory(() => ReadAdoptionUseCase(repository: sl.call()));

  // Lost
  sl.registerFactory(() => CreateLostUseCase(repository: sl.call()));
  sl.registerFactory(() => DeleteLostUseCase(repository: sl.call()));
  sl.registerFactory(() => ReadLostUseCase(repository: sl.call()));

  // Repository
  sl.registerLazySingleton<FirebaseRepository>(() => FirebaseRepositoryImpl(remoteDataSource: sl.call()));

  // Remote Data Source
  sl.registerLazySingleton<FirebaseRemoteDataSource>(() =>
      FirebaseRemoteDataSourceImpl(firebaseFirestore: sl.call(), firebaseAuth: sl.call(), firebaseStorage: sl.call()));

  // Externals
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseStorage = FirebaseStorage.instance;

  sl.registerLazySingleton(() => firebaseFirestore);
  sl.registerLazySingleton(() => firebaseAuth);
  sl.registerLazySingleton(() => firebaseStorage);
}
