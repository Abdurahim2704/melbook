import 'package:melbook/config/datasource.dart';

abstract class AuthRepository {
  Future<DataSource> registerUser({
    required String username,
    required String name,
    required String surname,
    required String phoneNumber,
    required String password,
  });

  Future<DataSource> loginUser(
      {required String username, required String password});

  Future<DataSource> getMe({
    required String token,
  });

  Future<DataSource> editData({
    required String? username,
    required String? name,
    required String? phoneNumber,
    required String? surname,
    required String? password,
  });
}
