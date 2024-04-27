import 'package:flutter_test/flutter_test.dart';
import 'package:melbook/config/datasource.dart';
import 'package:melbook/features/auth/data/models/user.dart';
import 'package:melbook/features/auth/data/service/auth_service.dart';
import 'package:melbook/features/auth/domain/repositories/auth_repository.dart';

void main() {
  AuthRepository authService = AuthService();

  group("Auth service", () {
    const username = "abdurahim1210";
    const password = "12345678911";
    const phoneNumber = "+9982874328979";

    // test("register user success", () async {
    //   final result = await authService.registerUser(
    //       username: username,
    //       name: "Abdurahim1202",
    //       surname: "Nasirdinov",
    //       phoneNumber: phoneNumber,
    //       password: password);
    //   print(result.message);
    //   expect(result, isA<DataSuccess<User>>());
    // });

    test("log in user", () async {
      final result =
          await authService.loginUser(username: username, password: password);
      expect(result, isA<DataSuccess<User>>());
    });

    test("get me", () async {
      final result = await authService.getMe();
      expect(result, isA<DataSuccess<User>>());
    });

    test("edit", () async {
      final result = await authService.editData(name: "Abdurahim yangi ism");
      if (result is DataSuccess<User>) {}
    });
  });
}
