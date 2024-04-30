import 'package:flutter/material.dart';

Text buildTextFieldHeaderText(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontWeight: FontWeight.w600,
      color: Color(0xFF201A21),
      fontSize: 22,
    ),
  );
}
