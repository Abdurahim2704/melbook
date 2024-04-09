import 'package:flutter/material.dart';
import 'package:melbook/presentation/intro.dart';
import 'package:melbook/presentation/screens/home_screen.dart';

bool haveUserAccount = false;
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: haveUserAccount? const HomeScreen() : const IntroScreen(),
    );
  }
}
