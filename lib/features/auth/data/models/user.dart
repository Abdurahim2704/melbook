import 'dart:convert';

class User {
  final String id;
  final String name;
  final String surname;
  final String userName;
  final String phoneNumber;
  final String password;
  final int version;
  final int userLevel;

  const User({
    required this.id,
    required this.name,
    required this.userName,
    required this.surname,
    required this.phoneNumber,
    required this.password,
    required this.version,
    required this.userLevel,
  });

  factory User.fromJson(Map<String, Object?> json) {
    final id = json["_id"] as String;
    final name = json["name"] as String;
    final surname = json["surname"] as String;
    final phoneNumber = json["phone_number"] as String;
    final userName = json["username"] as String;
    final password = json["password"] as String;
    final version = json["__v"] as int;
    final userLevel = json["user_level"] as int;

    return User(
        id: id,
        name: name,
        surname: surname,
        phoneNumber: phoneNumber,
        password: password,
        version: version,
        userLevel: userLevel,
        userName: userName);
  }

  String toJson() {
    return jsonEncode({
      "_id": id,
      "name": name,
      "surname": surname,
      "phone_number": phoneNumber,
      "username": userName,
      "password": password,
      "__v": version,
      "user_level": userLevel,
    });
  }
}
