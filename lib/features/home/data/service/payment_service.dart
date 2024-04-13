import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:melbook/config/core/constants/app_constants.dart';
import 'package:melbook/features/home/data/models/payment.dart';

class PaymentService {
  Future<PaymentModel> createPayment({
    required String bookId,
    required String phoneNumber,
    required String token,
    String domain = AppConstants.baseUrl,
    String endpoint = AppConstants.apiCreatePayment,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$domain$endpoint"),
        body: jsonEncode({
          'book_id': bookId,
          'phone_number': phoneNumber,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData =
            json.decode(response.body)['data'];
        final PaymentModel payment =
            PaymentModel.fromJson(responseData['payment']);
        return payment;
      } else {
        throw Exception('Failed to create payment: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create payment: $e');
    }
  }

  Future<PaymentModel> checkPayment({
    required String id,
    required String token,
    String domain = AppConstants.baseUrl,
    String endpoint = AppConstants.apiCheckClickPayment,
  }) async {
    try {
      final response = await http.put(
        Uri.parse("$domain$endpoint$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData =
            json.decode(response.body)['data'];
        final PaymentModel payment =
            PaymentModel.fromJson(responseData['payment']);
        return payment;
      } else {
        throw Exception('Failed to check payment: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to check payment: $e');
    }
  }
}
