import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:melbook/features/auth/domain/repositories/auth_repository.dart';
import 'package:melbook/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
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
    context.read<AuthBloc>().stream.listen((event) {
      if (event.message != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(event.message!)));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 80.h),
        child: Stack(
          children: [
            const CustomAppBar(
              displayText: "Profile",
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: 35.sp,
                ),
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 18.0.w, right: 18.w, bottom: 20.h),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30.h),
                  buildTextFieldHeaderText("Foydalanuvchi nomi"),
                  SizedBox(height: 12.h),
                  AuthTextField(
                    style: TextStyle(fontSize: 18.sp),
                    hinText: state.user?.userName,
                    textInputAction: TextInputAction.next,
                    controller: usernameCtrl,
                  ),
                  SizedBox(height: 20.h),
                  buildTextFieldHeaderText("Ism"),
                  SizedBox(height: 12.h),
                  AuthTextField(
                    style: TextStyle(fontSize: 18.sp),
                    controller: nameCtrl,
                    hinText: state.user?.name,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 20.h),
                  buildTextFieldHeaderText("Familiya"),
                  SizedBox(height: 12.h),
                  AuthTextField(
                    style: TextStyle(fontSize: 18.sp),
                    controller: surnameCtrl,
                    hinText: state.user?.surname,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 20.h),
                  buildTextFieldHeaderText("Telefon raqam"),
                  SizedBox(height: 12.h),
                  AuthTextField(
                    style: TextStyle(fontSize: 18.sp),
                    hinText: "\t${state.user?.phoneNumber}",
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
                  SizedBox(height: 20.h),
                  buildTextFieldHeaderText("Parol"),
                  SizedBox(height: 12.h),
                  AuthTextField(
                    style: TextStyle(fontSize: 18.sp),
                    hinText: "* * * * * * *",
                    controller: passwordCtrl,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 20.h),
                  buildTextFieldHeaderText("Parolni takrorlang"),
                  SizedBox(height: 12.h),
                  AuthTextField(
                    style: TextStyle(fontSize: 18.sp),
                    hinText: "* * * * * * *",
                    controller: confirmPasswordCtrl,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(height: 30.h),
                  Center(
                    child: PrimaryYellowElevatedButton(
                      displayText: "Saqlash",
                      onPressed: () {
                        if (confirmPasswordCtrl.text == passwordCtrl.text) {
                          context.read<AuthRepository>().editData(
                                username: usernameCtrl.text,
                                name: nameCtrl.text,
                                phoneNumber: phoneNumberCtrl.text,
                                password: passwordCtrl.text,
                                surname: surnameCtrl.text,
                              );
                        }
                      },
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
