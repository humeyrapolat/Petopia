import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petopia/features/presentation/cubit/adoption/adoption_cubit.dart';
import 'package:petopia/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:petopia/features/presentation/cubit/credential/credential_cubit.dart';
import 'package:petopia/features/presentation/cubit/lost/lost_cubit.dart';
import 'package:petopia/features/presentation/cubit/resetPassword/reset_password_cubit.dart';
import 'package:petopia/features/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:petopia/features/presentation/cubit/user/user_cubit.dart';
import 'package:petopia/features/presentation/page/credential/sign_in.dart';
import 'package:petopia/features/presentation/page/main_screen/main_screen.dart';
import 'package:petopia/on_generate_route.dart';
import 'package:petopia/util/consts.dart';

import 'features/presentation/cubit/user/get_single_other_user/get_single_other_user_cubit.dart';
import 'injection_container.dart' as di;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // we you multi bloc provider to provide multiple cubit when our app starts.
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => di.sl<AuthCubit>()..appStarted(context),
        ),
        BlocProvider<UserCubit>(
          create: (context) => di.sl<UserCubit>(),
        ),
        BlocProvider<CredentialCubit>(
          create: (context) => di.sl<CredentialCubit>(),
        ),
        BlocProvider<GetSingleUserCubit>(
          create: (context) => di.sl<GetSingleUserCubit>(),
        ),
        BlocProvider<ResetPasswordCubit>(
          create: (context) => di.sl<ResetPasswordCubit>(),
        ),
        BlocProvider(create: (_) => di.sl<GetSingleOtherUserCubit>()),
        BlocProvider(create: (_) => di.sl<AdoptionCubit>()),
        BlocProvider(create: (_) => di.sl<LostCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Petopia ',
        darkTheme: ThemeData.dark(),
        onGenerateRoute: OnGenerateRoute.route,
        initialRoute: "/",
        home: AnimatedSplashScreen(
            duration: 2500,
            splash: Icons.pets,
            nextScreen: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return MainScreen(
                    uid: authState.uid,
                  );
                } else {
                  return const SignInPage();
                }
              },
            ),
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: darkBlueGreenColor),
      ),
    );
  }
}
