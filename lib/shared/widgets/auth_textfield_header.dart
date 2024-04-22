import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Text buildTextFieldHeaderText(String text) {
  return Text(
    text,
    style: TextStyle(
      fontWeight: FontWeight.w600,
      color: const Color(0xFF201A21),
      fontSize: 18.sp,
    ),
  );
}
