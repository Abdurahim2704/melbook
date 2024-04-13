import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  const bookId = "660f5a9a54290cd58be20e49";
  const phoneNumber = "998930806416";
  const token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NjFhM2QxNTU0MjkwY2Q1OGJlMjIxODYiLCJpYXQiOjE3MTMwMzY2ODQsImV4cCI6MTcxNTYyODY4NH0.JvqmzRWhEvH8ZvNJjXhz6FUrx71hTjMfeOc11lLvigY";
  group("Payment service", () {
    test("Create payment", () async {
      final response = await http.post(
        Uri.parse("https://api.mobile.mel-book.uz/api/payments//click/create"),
        body: jsonEncode({
          'book_id': bookId,
          'phone_number': phoneNumber,
        }),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      final statusCode = response.statusCode;

      expect(statusCode, 200);
    });

    test("check payment", () async {
      const id = "154730722";
      final response = await http.put(
        Uri.parse("https://api.mobile.mel-book.uz/api/payments//click/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      final statusCode = response.statusCode;

      expect(statusCode, 200);
    });
  });
}
