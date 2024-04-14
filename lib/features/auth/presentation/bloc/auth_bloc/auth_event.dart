part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {
  const AuthEvent();
}

class SignUpEvent extends AuthEvent {
  final String name;
  final String username;
  final String surname;
  final String password;
  final String phoneNumber;

  const SignUpEvent({
    required this.name,
    required this.username,
    required this.surname,
    required this.password,
    required this.phoneNumber,
  });
}

class SignInEvent extends AuthEvent {
  final String username;
  final String password;

  const SignInEvent({
    required this.password,
    required this.username,
  });
}

class AutoLogInEvent extends AuthEvent {
  final String username;
  final String password;

  const AutoLogInEvent({
    required this.username,
    required this.password,
  });
}

class LogOut extends AuthEvent {}

class EditProfile extends AuthEvent {
  final String? userName;
  final String? name;
  final String? surname;
  final String? phoneNumber;
  final String? password;

  const EditProfile(
      {this.surname,
      this.name,
      this.userName,
      this.phoneNumber,
      this.password});
}
