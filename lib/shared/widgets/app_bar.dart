import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBar extends StatelessWidget {
  final String displayText;
  final String? trailingIconPath;
  final double? trailingIconHeight;
  final double? trailingIconWidth;

  const CustomAppBar({
    super.key,
    required this.displayText,
    this.trailingIconPath,
    this.trailingIconHeight,
    this.trailingIconWidth,
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
        padding: EdgeInsets.only(top: 22.h),
        child: Row(
          children: [
            SizedBox(width: 20.w),
            SvgPicture.asset(
              "assets/icons/ic_back.svg",
              height: 26.h,
              width: 26.w,
            ),
            SizedBox(width: 75.w),
            Text(
              displayText,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF201A21),
                fontSize: 19.sp,
              ),
            ),
            SizedBox(width: 80.w),
            if(trailingIconPath != null)SvgPicture.asset(
              trailingIconPath!,
              height: trailingIconHeight,
              width: trailingIconWidth,
            ),
          ],
        ),
      ),
    );
  }
}