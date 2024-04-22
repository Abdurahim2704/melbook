import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryYellowElevatedButton extends StatelessWidget {
  final String displayText;
  final void Function() onPressed;

  const PrimaryYellowElevatedButton({
    super.key,
    required this.displayText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shadowColor: Colors.transparent,
        fixedSize: Size(350.w, 50.h),
        backgroundColor: const Color(0xFFF6BE07),
      ),
      onPressed: onPressed,
      child: Text(
        displayText,
        style: TextStyle(
          fontSize: 17.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}