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
        titlePadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            "Sotib olishni xohlaysizmi?",
            style: TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              fixedSize: const Size(200, 50),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Bekor qilish",
              style: TextStyle(
                fontSize: 17,
                color: Colors.red,
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              fixedSize: const Size(200, 50),
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
          )
        ],
      );
    },
  );
}
