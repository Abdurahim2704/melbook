import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melbook/features/auth/domain/repositories/auth_repository.dart';
import 'package:melbook/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:melbook/features/auth/presentation/sign_up.dart';
import 'package:melbook/features/main/presentation/bloc/main_bloc.dart';
import 'package:melbook/features/main/presentation/main_screen.dart';
import 'package:melbook/locator.dart';

import 'features/auth/presentation/intro.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(),
          ),
          BlocProvider(
            create: (context) => MainBloc(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: showIntro
              ? const IntroScreen()
              : getIt<AuthRepository>().isSignedIn
                  ? const MainScreen()
                  : const SignUp(),
        ),
      ),
    );
  }
}
