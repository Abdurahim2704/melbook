import 'package:melbook/config/datasource.dart';
import 'package:melbook/features/auth/data/models/user.dart';

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

  User? get user;

  Future<DataSource> editData({
    String? username,
    String? name,
    String? phoneNumber,
    String? surname,
    String? password,
  });

  Future<void> resetToken();
}
