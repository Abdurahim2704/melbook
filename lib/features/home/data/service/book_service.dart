import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:melbook/config/core/constants/app_constants.dart';
import 'package:melbook/config/exceptions/expired_token_exception.dart';
import 'package:melbook/features/auth/domain/repositories/auth_repository.dart';
import 'package:melbook/locator.dart';

import '../models/bookdata.dart';

class BookService {
  /// #GET All Books
  Future<List<BookData>> methodGetAllBooks({
    String domain = AppConstants.baseUrl,
    String endpoint = AppConstants.apiGetAllBooks,
  }) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {}
    } on SocketException catch (_) {
      return const [];
    }

    final token = getIt<AuthRepository>().token;
    final response = await http.get(Uri.parse("$domain$endpoint"), headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 401) {
      throw ExpiredTokenException();
    }
    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> jsonList = json.decode(response.body)['data'];
      print(jsonList.length);
      final List<BookData> books =
          jsonList.map((json) => BookData.fromJson(json)).toList();
      return books;
    } else {
      throw Exception('Failed to fetch books: ${response.statusCode}');
    }
  }

  /// #GET Book By Id
  Future<BookData> methodGetBookById({
    required String bookId,
    String domain = AppConstants.baseUrl,
    String endpoint = AppConstants.apiGetAllBooks,
  }) async {
    try {
      final response = await http.get(Uri.parse("$domain$endpoint/$bookId"));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonData =
            json.decode(response.body)['data'];
        final BookData book = BookData.fromJson(jsonData);
        return book;
      } else {
        throw Exception('Failed to fetch book by ID: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch book by ID: $e');
    }
  }
}
