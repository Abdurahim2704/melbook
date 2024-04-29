import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:melbook/app.dart';
import 'package:melbook/locator.dart';
import 'package:melbook/observer.dart';

import 'features/connectivity_ctrl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUp();
  Bloc.observer = MyObserver();
  runApp(
    const App(),
  );
  Get.put(ConnectivityController(), permanent: true);
}
