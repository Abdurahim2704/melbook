import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AuthTextField extends StatelessWidget {
  final String? hinText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final TextEditingController controller;
  final TextStyle? style;
  final String? text;
  final MaskTextInputFormatter? formatter;

  const AuthTextField({
    super.key,
    this.hinText,
    this.formatter,
    this.keyboardType,
    this.textInputAction,
    this.prefixIcon,
    this.suffixIcon,
    this.inputFormatters,
    this.maxLength,
    this.text,
    required this.controller,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;
    return TextField(
      controller: controller,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      style: style,
      inputFormatters: [...?inputFormatters, if (formatter != null) formatter!],
      maxLength: maxLength,
      maxLines: null,
      decoration: InputDecoration(
        counterText: "",
        prefixIcon: prefixIcon,
        prefixStyle: style,
        prefixText: text,
        contentPadding: EdgeInsets.symmetric(
          horizontal: w * 0.057,
          vertical: h * 0.018,
        ),
        suffixIcon: suffixIcon,
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
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 20,
          color: Color(0xFFA4A3A4),
        ),
      ),
    );
  }
}
