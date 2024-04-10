import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthTextField extends StatelessWidget {
  final String hinText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;

  const AuthTextField({
    super.key,
    required this.hinText,
    this.keyboardType,
    this.textInputAction, this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      style: TextStyle(
        fontSize: 16.sp,
        color: const Color(0xFF201A21),
      ),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 17.h,
        ),
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
          borderSide: BorderSide(
            color: Color(0xFF00424E),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        // errorText: "Foydalanuvchi nomi topilmadi",
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
          borderSide: BorderSide(color: Color(0xFFFF0000)),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
          borderSide: BorderSide(color: Color(0xFFFF0000)),
        ),
        hintText: hinText,
        hintStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16.sp,
          color: const Color(0xFFA4A3A4),
        ),
      ),
    );
  }
}
