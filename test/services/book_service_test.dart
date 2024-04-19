import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:melbook/config/core/constants/app_constants.dart';

void main() {
  group("description", () {
    test("Get All Books", () async {
      const token =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NjFhM2QxNTU0MjkwY2Q1OGJlMjIxODYiLCJpYXQiOjE3MTM0ODk4NDcsImV4cCI6MTcxNjA4MTg0N30.MsBMjaNawsv5kn-emQbob6blpubYdEV9d07u1SHIBdc";
      const id = "660eed7954290cd58be20dac";
      final response = await http.get(
          Uri.parse("${AppConstants.baseUrl}${AppConstants.apiGetAllBooks}"),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $token',
          });

      print(jsonDecode(response.body)["data"][0]);
    });
  });
}
