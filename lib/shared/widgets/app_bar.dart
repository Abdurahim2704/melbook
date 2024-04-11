import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget {
  final String displayText;
  final String? trailingIconPath;
  final double? trailingIconHeight;
  final double? trailingIconWidth;
  final bool? isLeadingIconVisible;

  const CustomAppBar({
    super.key,
    required this.displayText,
    this.trailingIconPath,
    this.trailingIconHeight,
    this.trailingIconWidth,
    this.isLeadingIconVisible,
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
      height: 110.h,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(top: 22.h, left: 10.w, right: 10.w),
        child: Center(
          child: Text(
            displayText,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: const Color(0xFF201A21),
              fontSize: 19.sp,
            ),
          ),
        ),
      ),
    );
  }
}
