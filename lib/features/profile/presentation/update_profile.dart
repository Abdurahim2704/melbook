import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:melbook/shared/widgets/app_bar.dart';
import 'package:melbook/shared/widgets/auth_textfield.dart';
import 'package:melbook/shared/widgets/auth_textfield_header.dart';
import 'package:melbook/shared/widgets/primary_yellow_elevated_button.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final TextEditingController usernameCtrl = TextEditingController();

  final TextEditingController nameCtrl = TextEditingController();

  final TextEditingController surnameCtrl = TextEditingController();

  final TextEditingController phoneNumberCtrl = TextEditingController();

  final TextEditingController passwordCtrl = TextEditingController();

  final TextEditingController confirmPasswordCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  const PreferredSize(
        preferredSize: Size(double.infinity, 90),
        child: Stack(
          children: [
            CustomAppBar(
              displayText: "Profile",
            ),
            Align(alignment: Alignment.centerLeft,
            child: BackButton(),)
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 18.0.w, right: 18.w, bottom: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              buildTextFieldHeaderText("Foydalanuvchi nomi"),
              SizedBox(height: 12.h),
              AuthTextField(
                hinText: "Taxallusingizni kiriting",
                textInputAction: TextInputAction.next,
                controller: usernameCtrl,
              ),
              SizedBox(height: 15.h),
              buildTextFieldHeaderText("Ism"),
              SizedBox(height: 12.h),
              AuthTextField(
                controller: nameCtrl,
                hinText: "Ismingizni kiriting",
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 15.h),
              buildTextFieldHeaderText("Familiya"),
              SizedBox(height: 12.h),
              AuthTextField(
                controller: surnameCtrl,
                hinText: "Familiyangizni kiriting",
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 15.h),
              buildTextFieldHeaderText("Telefon raqam"),
              SizedBox(height: 12.h),
              AuthTextField(
                hinText: "\t+998 90 123 45 67",
                controller: phoneNumberCtrl,
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
              AuthTextField(
                hinText: "12345mkl",
                controller: passwordCtrl,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 15.h),
              buildTextFieldHeaderText("Parolni takrorlang"),
              SizedBox(height: 12.h),
              AuthTextField(
                hinText: "12345mkl",
                controller: confirmPasswordCtrl,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: 30.h),
              PrimaryYellowElevatedButton(
                displayText: "Saqlash",
                onPressed: () {
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
