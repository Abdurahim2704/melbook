import 'package:flutter_test/flutter_test.dart';
import 'package:melbook/features/auth/data/models/user.dart';

void main() {
  group("User model", () {
    test("from json", () {
      final json = {
        "message": "User fetched successfully",
        "status": 200,
        "data": {
          "_id": "65f349ba6f52c0b458ccb612",
          "username": "samandar",
          "name": "Samandar",
          "surname": "Temirxodjayev",
          "phone_number": "+998771234567",
          "password":
              r"$2b$10$3dXh1dYkC/KSCDLPGHEOAe5ItLeaZbQyIr3Aa5DO3NqeJkBwiK9km",
          "__v": 0,
          "user_level": 1
        }
      };

      final user = User.fromJson(json["data"] as Map<String, Object>);

      expect(user, const TypeMatcher<User>());
    });

    test("to json", () {
      final json = {
        "message": "User fetched successfully",
        "status": 200,
        "data": {
          "_id": "65f349ba6f52c0b458ccb612",
          "username": "samandar",
          "name": "Samandar",
          "surname": "Temirxodjayev",
          "phone_number": "+998771234567",
          "password":
              r"$2b$10$3dXh1dYkC/KSCDLPGHEOAe5ItLeaZbQyIr3Aa5DO3NqeJkBwiK9km",
          "__v": 0,
          "user_level": 1
        }
      };

      final user = User.fromJson(json["data"] as Map<String, Object>);
      final jsonString = user.toJson();
      print("jsonString: $jsonString");
      expect(jsonString, const TypeMatcher<String>());
    });
  });
}
