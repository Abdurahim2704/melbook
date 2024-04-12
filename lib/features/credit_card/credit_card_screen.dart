import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:melbook/shared/widgets/app_bar.dart';
import 'package:melbook/shared/widgets/auth_textfield.dart';
import 'package:melbook/shared/widgets/auth_textfield_header.dart';
import 'package:melbook/shared/widgets/primary_yellow_elevated_button.dart';
import 'package:melbook/utils.dart';

import 'code_authorization_screen.dart';

class CreditCardScreen extends StatefulWidget {
  const CreditCardScreen({super.key});

  @override
  State<CreditCardScreen> createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
  List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 90),
        child: CustomAppBar(displayText: "Plastik karta"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),
            buildTextFieldHeaderText("Karta egasining ismi"),
            SizedBox(height: 12.h),
            AuthTextField(
              hinText: "Foydalanuvchi nomini kiriting",
              textInputAction: TextInputAction.next,
              style: TextStyle(
                fontSize: 16.sp,
                color: const Color(0xFF201A21),
              ),
              controller: controllers[0],
            ),
            SizedBox(height: 20.h),
            buildTextFieldHeaderText("Karta raqami"),
            SizedBox(height: 12.h),
            AuthTextField(
              hinText: "0000 0000 00000 0000",
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: [CardNumberFormatter()],
              controller: controllers[1],
              maxLength: 19,
              style: TextStyle(
                fontSize: 16.sp,
                color: const Color(0xFF201A21),
              ),
            ),
            SizedBox(height: 30.h),
            buildTextFieldHeaderText("Amal qilish muddati"),
            SizedBox(height: 12.h),
            AuthTextField(
              hinText: "00/00",
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              inputFormatters: [CardDateFormatter()],
              suffixIcon: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset("assets/icons/ic_calendar.svg"),
              ),
              style: TextStyle(
                fontSize: 16.sp,
                color: const Color(0xFF201A21),
              ), controller: controllers[2],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 40.0.h, left: 20.w, right: 20.w),
        child: PrimaryYellowElevatedButton(
          displayText: "Davom etish",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CodeAuthScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}
