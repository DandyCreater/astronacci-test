import 'package:astronacci/core/routes/routes.dart';
import 'package:astronacci/feature/dashboard/presentation/bloc/user-bloc/user_bloc.dart';
import 'package:astronacci/feature/profile/presentation/bloc/profile-bloc/profile_bloc.dart';
import 'package:astronacci/feature/profile/presentation/cubit/edit-profile-cubit/edit_profile_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/injection/injection_container.dart';
import 'feature/splashscreen/splashscreen.dart';
import 'core/injection/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<UserBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<ProfileBloc>(),
        ),
        BlocProvider(
          create: (context) => EditProfileCubit(),
        )
      ],
      child: MaterialApp(
        home: const SplashScreen(),
        onGenerateRoute: AppRouter().onGenerate,
      ),
    );
  }
}
