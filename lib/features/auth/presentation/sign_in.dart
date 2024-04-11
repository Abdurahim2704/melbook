import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melbook/presentation/screens/home/home_screen.dart';
import 'package:melbook/shared/widgets/app_bar.dart';
import 'package:melbook/shared/widgets/auth_textfield.dart';
import 'package:melbook/shared/widgets/auth_textfield_header.dart';
import 'package:melbook/shared/widgets/primary_yellow_elevated_button.dart';

import 'bloc/auth_bloc/auth_bloc.dart';

class SignIn extends StatefulWidget {
  SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final usernameCtrl = TextEditingController();

  final passwordCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().stream.listen((event) {
      if (event.message != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(event.message!)));
      }
    });
  }

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
              controller: usernameCtrl,
              hinText: "Foydalanuvchi nomini kiriting",
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 20.h),

            /// #TextField Header
            buildTextFieldHeaderText("Parol"),

            SizedBox(height: 12.h),

            /// #TextField Password
            AuthTextField(
              hinText: "12345mkl",
              controller: passwordCtrl,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
            ),
          ],
        ),
      ),

      /// Navigator Button
      bottomNavigationBar: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SignInSuccessState) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage1(),
                ));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(bottom: 40.0.h, left: 20.w, right: 20.w),
            child: PrimaryYellowElevatedButton(
              displayText: "Tizimga kirish",
              onPressed: () {
                context.read<AuthBloc>().add(SignInEvent(
                      password: passwordCtrl.text,
                      username: usernameCtrl.text,
                    ));
              },
            ),
          );
        },
      ),
    );
  }
}
