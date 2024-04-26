import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:melbook/app.dart';
import 'package:melbook/locator.dart';
import 'package:melbook/observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUp();
  Bloc.observer = MyObserver();
  runApp(
    const App(),
  );
}
