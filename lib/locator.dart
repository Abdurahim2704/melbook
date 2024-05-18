import 'package:get_it/get_it.dart';
import 'package:melbook/features/audio/presentation/bloc/player/player_bloc.dart';
import 'package:melbook/features/auth/data/service/auth_service.dart';
import 'package:melbook/features/auth/data/service/local_service.dart';
import 'package:melbook/features/auth/domain/repositories/auth_repository.dart';
import 'package:melbook/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:melbook/features/home/data/service/last_read.dart';
import 'package:melbook/features/home/presentation/bloc/book/book_bloc.dart';
import 'package:melbook/features/home/presentation/bloc/local_storage/local_storage_bloc.dart';
import 'package:melbook/features/home/presentation/bloc/main_bloc/main_bloc.dart';
import 'package:melbook/features/home/presentation/bloc/payment_bloc/payment_bloc.dart';

late GetIt getIt;
bool showIntro = false;

Future<void> setUp() async {
  registerGetIt();
  await LocalDBService.init();
  if (await LocalDBService.hasUser()) {
    final username = await LocalDBService.getUsername();
    final password = await LocalDBService.getPassword();
    await getIt<AuthRepository>()
        .loginUser(username: username ?? "", password: password ?? "");
  }
  showIntro = await LocalDBService.getShowIntro();
}

Future<void> registerGetIt() async {
  getIt = GetIt.instance;
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthService(),
  );
  getIt.registerLazySingleton<SharedPreferenceService>(
      () => SharedPreferenceService());

  getIt.registerLazySingleton<AuthBloc>(() => AuthBloc());
  getIt.registerLazySingleton<LocalStorageBloc>(() => LocalStorageBloc());
  getIt.registerLazySingleton<MainBloc>(() => MainBloc());
  getIt.registerLazySingleton<BookBloc>(() => BookBloc());
  getIt.registerLazySingleton<PaymentBloc>(() => PaymentBloc());
  getIt.registerLazySingleton<PlayerBloc>(() => PlayerBloc());
}
