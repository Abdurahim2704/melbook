import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        title: Center(
          child: Text(
            "Sotib olishni xohlaysizmi?",
            style: TextStyle(fontSize: 32.sp),
            textAlign: TextAlign.center,
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              fixedSize: Size(200.w, 50.h),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Bekor qilish",
              style: TextStyle(
                fontSize: 23.sp,
                color: Colors.red,
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              fixedSize: Size(200.w, 50.h),
            ),
            onPressed: () {
              context.read<PaymentBloc>().add(
                    CreatePayment(
                      bookId: bookId,
                    ),
                  );
            },
            child: Transform.scale(
              scaleX: 1.5,
              scaleY: 1.5,
              child: Image.asset(
                "assets/images/img_click.png",
              ),
            ),
          )
        ],
      );
    },
  );
}
