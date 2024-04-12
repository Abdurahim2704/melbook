import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:melbook/config/core/constants/app_constants.dart';
import 'package:melbook/config/datasource.dart';
import 'package:melbook/features/auth/data/models/user.dart';
import 'package:melbook/features/auth/domain/repositories/auth_repository.dart';

class AuthService extends AuthRepository {
  String _token = "";
  User? _user;

  @override
  Future<DataSource> editData(
      {String? username,
      String? name,
      String? phoneNumber,
      String? surname,
      String? password}) async {
    final body = {
      "username": username ?? _user!.userName,
      "name": name ?? _user!.name,
      "surname": surname ?? _user!.surname,
      "phone_number": phoneNumber ?? _user!.phoneNumber,
      "password": password ?? _user!.password
    };
    final response = await http.put(
      Uri.parse(
        "${AppConstants.baseUrl}${AppConstants.apiEditUser}",
      ),
      body: jsonEncode(body),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode != 200) {
      return DataFailure(
          message:
              (jsonDecode(response.body) as Map<String, dynamic>)["message"]);
    }
    final user = User.fromJson((jsonDecode(response.body)
        as Map<String, dynamic>)["data"] as Map<String, Object?>);
    _user = user;
    return DataSuccess<User>(
        data: user, message: jsonDecode(response.body)["message"]);
  }

  @override
  Future<DataSource> getMe() async {
    final data = await http.get(
      Uri.parse("${AppConstants.baseUrl}${AppConstants.apiGetMe}"),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );

    if (data.statusCode == 401) {
      loginUser(username: _user!.userName, password: _user!.password);
      return await getMe();
    } else if (data.statusCode != 200) {
      return DataFailure(message: jsonDecode(data.body)["message"]);
    }
    final user = User.fromJson((jsonDecode(data.body)
        as Map<String, dynamic>)["data"] as Map<String, Object?>);

    return DataSuccess<User>(
        data: user, message: jsonDecode(data.body)["message"]);
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
    _token = jsonDecode(data.body)["data"]["token"];
    final user = User.fromJson((jsonDecode(data.body)
        as Map<String, dynamic>)["data"]["user"] as Map<String, Object?>);
    _user = user;
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
    _token = jsonDecode(data.body)["data"]["token"];
    final user = User.fromJson((jsonDecode(data.body)
        as Map<String, dynamic>)["data"]["user"] as Map<String, Object?>);
    _user = user;
    return DataSuccess<User>(
        data: user, message: jsonDecode(data.body)["message"]);
  }

  @override
  String get token {
    return _token;
  }

  @override
  bool get isSignedIn => _user != null;

  @override
  User? get user => _user;

  @override
  Future<void> resetToken() async {
    final body = {"username": _user!.userName, "password": _user!.password};
    final data = await http.post(
        Uri.parse("${AppConstants.baseUrl}${AppConstants.apiLoginUser}"),
        body: jsonEncode(body),
        headers: {"Content-Type": "application/json"});

    if (data.statusCode != 200) {
      throw Exception("reset Token failed: ${data.statusCode}");
    }
    _token = jsonDecode(data.body)["data"]["token"];
    final user = User.fromJson((jsonDecode(data.body)
        as Map<String, dynamic>)["data"]["user"] as Map<String, Object?>);
    _user = user;
    return;
  }
}
