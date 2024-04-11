import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomAlertDialog extends StatelessWidget {
  final String displayText;
  final void Function() onPressed;

  const CustomAlertDialog({
    super.key,
    required this.displayText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Column(
        children: [
          const SizedBox(height: 10),
          SvgPicture.asset(
            "assets/icons/ic_dialog_pattern.svg",
            width: 180.w,
            height: 180.h,
          ),
          SizedBox(height: 40.h),
          Text(
            displayText,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF201A21),
            ),
          ),
          SizedBox(height: 80.h),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF201A21),
              fixedSize: Size(300.w, 50.h),
            ),
            onPressed: onPressed,
            child: Text(
              "OK",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17.sp,
                color: const Color(0xFFFFFFFF),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
