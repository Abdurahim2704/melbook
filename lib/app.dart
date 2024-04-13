import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melbook/features/auth/data/service/local_service.dart';
import 'package:melbook/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:melbook/features/auth/presentation/sign_up.dart';
import 'package:melbook/features/home/presentation/bloc/book/book_bloc.dart';
import 'package:melbook/features/main/presentation/bloc/main_bloc.dart';
import 'package:melbook/features/main/presentation/main_screen.dart';
import 'package:melbook/locator.dart';

import 'features/auth/presentation/intro.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(),
          ),
          BlocProvider(
            create: (context) => MainBloc(),
          ),
          BlocProvider(
            create: (context) => BookBloc(),
          )
        ],
        child: FutureBuilder<bool>(
            future: LocalDBService.hasUser(),
            initialData: false,
            builder: (context, snapshot) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: showIntro
                    ? const IntroScreen()
                    : snapshot.data!
                        ? const MainScreen()
                        : const SignUp(),
              );
            }),
      ),
    );
  }
}
