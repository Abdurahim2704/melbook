import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:melbook/features/home/presentation/main_screen.dart';
import 'package:melbook/features/home/presentation/saved/saved_pages.dart';

import 'auth/data/service/local_service.dart';

class ConnectivityController extends GetxController {
  final Connectivity _connectvity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectvity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) async {
    print(result.first.name);
    bool connection = await InternetConnectionChecker().hasConnection;
    if (result.first == ConnectivityResult.none) {
      Get.rawSnackbar(
          messageText: const Text(
            "You are offline",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          duration: const Duration(seconds: 10));
      Navigator.pushReplacement(
          Get.context!,
          MaterialPageRoute(
            builder: (context) => const SavedPages(),
          ));
    } else {
      if (Get.isSnackbarOpen && connection) {
        await Get.closeCurrentSnackbar();
        Get.rawSnackbar(
            messageText: const Text(
          "You are online",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ));

        LocalDBService.hasUser().then((value) {
          if (value) {
            Navigator.push(
                Get.context!,
                MaterialPageRoute(
                  builder: (context) => const MainScreen(),
                ));
          }
        });
      }
    }
  }
}
