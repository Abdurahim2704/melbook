import 'package:flutter/material.dart';
import 'package:melbook/app.dart';
import 'package:melbook/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUp();
  runApp(
    const App(),
  );
}
