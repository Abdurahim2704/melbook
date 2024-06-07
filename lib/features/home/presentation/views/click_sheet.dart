import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melbook/features/home/presentation/bloc/payment_bloc/payment_bloc.dart';

void showClickSheet(BuildContext context, String bookId) {
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return AlertDialog(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        titlePadding: const EdgeInsets.all(60),
        backgroundColor: Colors.white,
        title: Text(
          "Sotib olishni xohlaysizmi?",
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(12),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Bekor qilish",
              style: TextStyle(
                fontSize: 23,
                color: Colors.red,
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(12),
            ),
            onPressed: () {
              context.read<PaymentBloc>().add(
                    CreatePayment(
                      bookId: bookId,
                    ),
                  );
            },
            child: Image.asset(
              "assets/images/img_click.png",
            ),
          ),
        ],
      );
    },
  );
}
