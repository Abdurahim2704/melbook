import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melbook/shared/widgets/app_bar.dart';
import 'package:melbook/shared/widgets/auth_textfield.dart';
import 'package:melbook/shared/widgets/auth_textfield_header.dart';
import 'package:melbook/shared/widgets/primary_yellow_elevated_button.dart';

class CodeAuthScreen extends StatelessWidget {
  const CodeAuthScreen({super.key});

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
            buildTextFieldHeaderText("Melbookni tekshirish kodi"),
            SizedBox(height: 30.h),
            const Text(
              """Biz telefon raqamiga OTP kodini yubordik -- --- -5 55 davomi ostidagi OTP kodini kiriting""",
            ),
            SizedBox(height: 60.h),
            const AuthTextField(
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 30.h),
            Center(child: buildTextFieldHeaderText("Kod kelmadimi?")),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 40.0.h, left: 20.w, right: 20.w),
        child: PrimaryYellowElevatedButton(
          displayText: "Davom etish",
          onPressed: () {},
        ),
      ),
    );
  }
}
