import 'package:flutter_test/flutter_test.dart';
import 'package:melbook/config/datasource.dart';
import 'package:melbook/features/auth/data/models/user.dart';
import 'package:melbook/features/auth/data/service/auth_service.dart';
import 'package:melbook/features/auth/domain/repositories/auth_repository.dart';

void main() {
  group("Auth service", () {
    AuthRepository authService = AuthService();
    final username = "abdurahim9099";
    final password = "123456890";
    test("register user success", () async {
      final result = await authService.registerUser(
          username: "abdurahim9099",
          name: "Abdurahim1202",
          surname: "Nasirdinov",
          phoneNumber: "+998905484139",
          password: "123456890");
      print(result.message);
      expect(result, isA<DataSuccess<User>>());
    });
    test("log in user", () async {
      final result =
          await authService.loginUser(username: username, password: password);
      print(result.message);
      expect(result, isA<DataSuccess<User>>());
    });
  });
}
