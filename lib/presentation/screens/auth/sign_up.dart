import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:melbook/shared/widgets/app_bar.dart';
import 'package:melbook/shared/widgets/auth_textfield.dart';
import 'package:melbook/shared/widgets/auth_textfield_header.dart';
import 'package:melbook/shared/widgets/primary_yellow_elevated_button.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 90),
        child: CustomAppBar(
          displayText: "Ro’yxatdan o’tish",
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 18.0.w, right: 18.w, bottom: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h),
                buildTextFieldHeaderText("Foydalanuvchi nomi"),
                SizedBox(height: 12.h),
                const AuthTextField(
                  hinText: "Taxallusingizni kiriting",
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 15.h),
                buildTextFieldHeaderText("Ism"),
                SizedBox(height: 12.h),
                const AuthTextField(
                  hinText: "Ismingizni kiriting",
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 15.h),
                buildTextFieldHeaderText("Familiya"),
                SizedBox(height: 12.h),
                const AuthTextField(
                  hinText: "Familiyangizni kiriting",
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 15.h),
                buildTextFieldHeaderText("Telefon raqam"),
                SizedBox(height: 12.h),
                AuthTextField(
                  hinText: "\t+998 90 123 45 67",
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(
                      "assets/icons/ic_phone.svg",
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                buildTextFieldHeaderText("Parol"),
                SizedBox(height: 12.h),
                const AuthTextField(
                  hinText: "12345mkl",
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 15.h),
                buildTextFieldHeaderText("Parolni takrorlang"),
                SizedBox(height: 12.h),
                const AuthTextField(
                  hinText: "12345mkl",
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(height: 30.h),
                PrimaryYellowElevatedButton(
                  displayText: "Ro’yxatdan o’tish",
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
