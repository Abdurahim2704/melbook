import 'package:flutter/material.dart';
import 'package:melbook/features/auth/domain/repositories/auth_repository.dart';
import 'package:melbook/features/home/data/service/payment_service.dart';
import 'package:melbook/locator.dart';

void showClickSheet(BuildContext context, String bookId) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          title: const Center(
              child: Text(
            "Sotib olishni xohlaysizmi?",
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          )),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Bekor qilish",
                  style: TextStyle(color: Colors.red),
                )),
            TextButton(
              onPressed: () {
                PaymentService().createPayment(
                    bookId: bookId,
                    phoneNumber: getIt<AuthRepository>().user!.phoneNumber,
                    token: getIt<AuthRepository>().token);
              },
              child: Image.asset("assets/images/img_click.png"),
            )
          ]);
    },
  );
}
