part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  final String? message;
  final User? user;

  const AuthState({this.user, this.message});
}

final class AuthInitial extends AuthState {
  const AuthInitial({super.user});
}

class AuthLoadingState extends AuthState {
  const AuthLoadingState({super.user});
}

class AuthErrorState extends AuthState {
  const AuthErrorState({
    required super.message,
    super.user,
  });
}

class SignUpSuccessState extends AuthState {
  const SignUpSuccessState({
    required super.message,
    required super.user,
  });
}

class SignInSuccessState extends AuthState {
  const SignInSuccessState({
    required super.message,
    required super.user,
  });
}
