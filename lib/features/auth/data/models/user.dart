import 'dart:convert';

import 'package:flutter/cupertino.dart';

class User {
  final String id;
  final String name;
  final String surname;
  final String userName;
  final String phoneNumber;
  final String password;
  final int version;
  final List<String> boughtBooks;
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
    required this.boughtBooks,
  });

  factory User.fromJson(Map<String, Object?> json) {
    debugPrint(json.toString());
    final id = json["_id"] as String;
    final boughtBooks = (json["boughtBooks"] ?? []) as List<String>;
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
        userName: userName,
        boughtBooks: boughtBooks);
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
      "boughtBooks": boughtBooks,
      "user_level": userLevel,
    });
  }
}
