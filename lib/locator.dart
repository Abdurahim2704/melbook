import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:get_it/get_it.dart';
import 'package:melbook/features/auth/data/service/auth_service.dart';
import 'package:melbook/features/auth/data/service/local_service.dart';
import 'package:melbook/features/auth/domain/repositories/auth_repository.dart';

late GetIt getIt;
bool showIntro = false;

Future<void> setUp() async {
  getIt = GetIt.instance;
  getIt.registerSingleton<AuthRepository>(AuthService());
  await LocalDBService.init();
  if (await LocalDBService.hasUser()) {
    final username = await LocalDBService.getUsername();
    final password = await LocalDBService.getPassword();
    await getIt<AuthRepository>()
        .loginUser(username: username ?? "", password: password ?? "");
  }
  showIntro = await LocalDBService.getShowIntro();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    final myDevice = await deviceInfo.androidInfo;
    print("Device id:${myDevice.id}");
    print("Android id:${myDevice.androidId}");
    print("Board :${myDevice.board}");
    print("Brand:${myDevice.brand}");
  }
}
