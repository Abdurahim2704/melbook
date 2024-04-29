import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String displayText;

  const CustomAppBar({
    super.key,
    required this.displayText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF2F2F2),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(36),
          bottomRight: Radius.circular(36),
        ),
      ),
      height: 110,
      width: double.infinity,
      child: Center(
        child: Text(
          displayText,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF201A21),
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
