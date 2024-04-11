import 'package:melbook/config/datasource.dart';

abstract class AuthRepository {
  String get token;

  Future<DataSource> registerUser({
    required String username,
    required String name,
    required String surname,
    required String phoneNumber,
    required String password,
  });

  bool get isSignedIn;

  Future<DataSource> loginUser(
      {required String username, required String password});

  Future<DataSource> getMe();

  Future<DataSource> editData({
    String? username,
    String? name,
    String? phoneNumber,
    String? surname,
    String? password,
  });
}
