import 'package:bloc/bloc.dart';
import 'package:melbook/config/datasource.dart';
import 'package:melbook/features/auth/data/models/user.dart';
import 'package:melbook/features/auth/data/service/local_service.dart';
import 'package:melbook/features/auth/domain/repositories/auth_repository.dart';
import 'package:meta/meta.dart';

import '../../../../../locator.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthInitial()) {
    on<SignUpEvent>(_signUpEvent);
    on<SignInEvent>(_signInEvent);
    on<AutoLogInEvent>(_autologInEvent);
  }

  Future<void> _signUpEvent(SignUpEvent event, Emitter<AuthState> emit) async {
    final authService = getIt<AuthRepository>();
    emit(AuthLoadingState(user: state.user));
    final result = await authService.registerUser(
      username: event.username,
      name: event.name,
      surname: event.surname,
      phoneNumber: event.phoneNumber,
      password: event.password,
    );

    if (result is DataFailure) {
      emit(AuthErrorState(message: result.message, user: state.user));
      return;
    }
    LocalDBService.setPassword(event.password);
    LocalDBService.setUsername(event.username);
    emit(SignUpSuccessState(
        user: (result as DataSuccess<User>).data, message: result.message));
  }

  Future<void> _signInEvent(SignInEvent event, Emitter<AuthState> emit) async {
    final authService = getIt<AuthRepository>();
    emit(AuthLoadingState(user: state.user));
    final result = await authService.loginUser(
      username: event.username,
      password: event.password,
    );

    if (result is DataFailure) {
      emit(AuthErrorState(message: result.message, user: state.user));
      return;
    }
    LocalDBService.setPassword(event.password);
    LocalDBService.setUsername(event.username);
    emit(SignInSuccessState(
        user: (result as DataSuccess<User>).data, message: result.message));
  }

  Future<void> _autologInEvent(
      AutoLogInEvent event, Emitter<AuthState> emit) async {
    final authService = getIt<AuthRepository>();
    final username = await LocalDBService.getUsername();
    final password = await LocalDBService.getPassword();
    emit(AuthLoadingState(user: state.user));
    final result = await authService.loginUser(
      username: username!,
      password: password!,
    );

    if (result is DataFailure) {
      emit(AuthErrorState(message: result.message, user: state.user));
      return;
    }
    LocalDBService.setPassword(event.password);
    LocalDBService.setUsername(event.username);
    emit(SignInSuccessState(
        user: (result as DataSuccess<User>).data, message: result.message));
  }
}