import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:melbook/config/core/constants/app_constants.dart';
import 'package:melbook/config/datasource.dart';
import 'package:melbook/features/auth/data/models/user.dart';
import 'package:melbook/features/auth/domain/repositories/auth_repository.dart';

class AuthService extends AuthRepository {
  @override
  Future<DataSource> editData(
      {required String? username,
      required String? name,
      required String? phoneNumber,
      required String? surname,
      required String? password}) {
    // TODO: implement editData
    throw UnimplementedError();
  }

  @override
  Future<DataSource> getMe({required String token}) {
    // TODO: implement getMe
    throw UnimplementedError();
  }

  @override
  Future<DataSource> loginUser(
      {required String username, required String password}) async {
    final body = {"username": username, "password": password};
    final data = await http.post(
        Uri.parse("${AppConstants.baseUrl}${AppConstants.apiLoginUser}"),
        body: jsonEncode(body),
        headers: {"Content-Type": "application/json"});

    if (data.statusCode != 200) {
      return DataFailure(message: jsonDecode(data.body)["message"]);
    }
    final user = User.fromJson((jsonDecode(data.body)
        as Map<String, dynamic>)["data"]["user"] as Map<String, Object?>);
    return DataSuccess<User>(
        data: user, message: jsonDecode(data.body)["message"]);
  }

  @override
  Future<DataSource> registerUser({
    required String username,
    required String name,
    required String surname,
    required String phoneNumber,
    required String password,
  }) async {
    final body = {
      "username": username,
      "name": name,
      "surname": surname,
      "phone_number": phoneNumber,
      "password": password
    };
    final data = await http.post(
        Uri.parse("${AppConstants.baseUrl}${AppConstants.apiRegisterUser}"),
        body: jsonEncode(body),
        headers: {"Content-Type": "application/json"});

    if (data.statusCode == 400 || data.statusCode == 404) {
      return DataFailure(message: jsonDecode(data.body)["message"]);
    }
    final user = User.fromJson((jsonDecode(data.body)
        as Map<String, dynamic>)["data"]["user"] as Map<String, Object?>);
    return DataSuccess<User>(
        data: user, message: jsonDecode(data.body)["message"]);
  }
}
