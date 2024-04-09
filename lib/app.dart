import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melbook/presentation/intro.dart';
import 'package:melbook/presentation/screens/auth/sign_in.dart';
import 'package:melbook/presentation/screens/home_screen.dart';

bool haveUserAccount = false;
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: haveUserAccount? const IntroScreen() : const SignIn(),
      ),
    );
  }
}
