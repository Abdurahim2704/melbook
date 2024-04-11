import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melbook/presentation/screens/home/home_screen.dart';
import 'package:melbook/shared/widgets/app_bar.dart';
import 'package:melbook/shared/widgets/auth_textfield.dart';
import 'package:melbook/shared/widgets/auth_textfield_header.dart';
import 'package:melbook/shared/widgets/primary_yellow_elevated_button.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 90),
        child: CustomAppBar(displayText: "Tizimga kirish"),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),

            /// #Header Logo
            Center(
              child: Image(
                image: const AssetImage("assets/images/img_logo_melbook.png"),
                width: 165.w,
                height: 50.h,
              ),
            ),
            SizedBox(height: 40.h),

            /// #TextField Header
            buildTextFieldHeaderText("Foydalanuvchi nomi"),
            SizedBox(height: 12.h),

            /// #TextField Username
            AuthTextField(
              hinText: "Foydalanuvchi nomini kiriting",
              textInputAction: TextInputAction.next,
              style: TextStyle(
                fontSize: 16.sp,
                color: const Color(0xFF201A21),
              ),
            ),
            SizedBox(height: 20.h),

            /// #TextField Header
            buildTextFieldHeaderText("Parol"),

            SizedBox(height: 12.h),

            /// #TextField Password
            AuthTextField(
              hinText: "12345mkl",
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              style: TextStyle(
                fontSize: 16.sp,
                color: const Color(0xFF201A21),
              ),
            ),
          ],
        ),
      ),

      /// Navigator Button
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 40.0.h, left: 20.w, right: 20.w),
        child: PrimaryYellowElevatedButton(
          displayText: "Tizimga kirish",
          onPressed: () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage1(),), (route) => false);
          },
        ),
      ),
    );
  }


}
