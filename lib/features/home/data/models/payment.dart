import 'dart:convert';

class PaymentModel {
  final String id;
  final String userId;
  final int status;
  final String bookId;
  final String type;
  final String date;
  final String createdAt;
  final String updatedAt;
  final int v;
  final String paymentUuid;

  PaymentModel({
    required this.id,
    required this.userId,
    required this.status,
    required this.bookId,
    required this.type,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.paymentUuid,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    final id = json['_id'] as String;
    final userId = json['user_id'] as String;
    final status = json['status'] as int;
    final bookId = json['book_id'] as String;
    final type = json['type'] as String;
    final date = json['date'] as String;
    final createdAt = json['createdAt'] as String;
    final updatedAt = json['updatedAt'] as String;
    final v = json['__v'] as int;
    final paymentUuid = json['payment_uuid'] as String;

    return PaymentModel(
      id: id,
      userId: userId,
      status: status,
      bookId: bookId,
      type: type,
      date: date,
      createdAt: createdAt,
      updatedAt: updatedAt,
      v: v,
      paymentUuid: paymentUuid,
    );
  }

  String toJson() {
    return jsonEncode({
      '_id': id,
      'user_id': userId,
      'status': status,
      'book_id': bookId,
      'type': type,
      'date': date,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
      'payment_uuid': paymentUuid,
    });
  }
}
