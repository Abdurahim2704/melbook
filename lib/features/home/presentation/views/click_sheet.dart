import 'package:flutter/material.dart';
import 'package:melbook/shared/widgets/custom_alert_dialog.dart';

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
                showDialog(
                  context: context,
                  builder: (context) {
                    return CustomAlertDialog(
                      displayText: "To'landi",
                      onPressed: () {},
                    );
                  },
                );

                // PaymentService().createPayment(
                //     bookId: bookId,
                //     phoneNumber: getIt<AuthRepository>().user!.phoneNumber,
                //     token: getIt<AuthRepository>().token);
              },
              child: Image.asset("assets/images/img_click.png"),
            )
          ]);
    },
  );
}
