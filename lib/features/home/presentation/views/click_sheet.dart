import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melbook/features/home/presentation/bloc/payment_bloc/payment_bloc.dart';

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
                context.read<PaymentBloc>().add(
                      CreatePayment(
                        bookId: bookId,
                      ),
                    );
              },
              child: Image.asset("assets/images/img_click.png"),
            )
          ]);
    },
  );
}
