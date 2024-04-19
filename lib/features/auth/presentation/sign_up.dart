import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:melbook/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:melbook/features/auth/presentation/sign_in.dart';
import 'package:melbook/shared/widgets/app_bar.dart';
import 'package:melbook/shared/widgets/auth_textfield.dart';
import 'package:melbook/shared/widgets/auth_textfield_header.dart';
import 'package:melbook/shared/widgets/primary_yellow_elevated_button.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController usernameCtrl = TextEditingController();

  final TextEditingController nameCtrl = TextEditingController();

  final TextEditingController surnameCtrl = TextEditingController();

  final TextEditingController phoneNumberCtrl = TextEditingController();

  final TextEditingController passwordCtrl = TextEditingController();

  final TextEditingController confirmPasswordCtrl = TextEditingController();
  var maskTextInputFormatter = MaskTextInputFormatter(
    mask: ' ## ###-##-##',
    filter: {
      "#": RegExp(r'[0-9]'),
    },
  );

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().stream.listen((event) {
      if (event.message != null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(event.message!, style: TextStyle(fontSize: 14.sp)),
          ));
        }
      }
    });
  }

  String formatPhoneNumber(String text) {
    text = text.replaceAll(" ", "");
    text = text.replaceAll("-", "");
    return "+998$text";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 90.h),
        child: const CustomAppBar(
          displayText: "Ro’yxatdan o’tish",
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
                style:
                    TextStyle(fontSize: 16.sp, color: const Color(0xFF201A21)),
                hinText: "Taxallusingizni kiriting",
                textInputAction: TextInputAction.next,
                controller: usernameCtrl,
              ),
              SizedBox(height: 15.h),
              buildTextFieldHeaderText("Ism"),
              SizedBox(height: 12.h),
              AuthTextField(
                style:
                    TextStyle(fontSize: 16.sp, color: const Color(0xFF201A21)),
                controller: nameCtrl,
                hinText: "Ismingizni kiriting",
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 15.h),
              buildTextFieldHeaderText("Familiya"),
              SizedBox(height: 12.h),
              AuthTextField(
                style:
                    TextStyle(fontSize: 16.sp, color: const Color(0xFF201A21)),
                controller: surnameCtrl,
                hinText: "Familiyangizni kiriting",
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 15.h),
              buildTextFieldHeaderText("Telefon raqam"),
              SizedBox(height: 12.h),
              AuthTextField(
                style:
                    TextStyle(fontSize: 16.sp, color: const Color(0xFF201A21)),
                hinText: "90 123 45 67",
                text: "+998 ",
                controller: phoneNumberCtrl,
                formatter: maskTextInputFormatter,
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
                style:
                    TextStyle(fontSize: 16.sp, color: const Color(0xFF201A21)),
                hinText: "12345mkl",
                controller: passwordCtrl,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 15.h),
              buildTextFieldHeaderText("Parolni takrorlang"),
              SizedBox(height: 12.h),
              AuthTextField(
                style:
                    TextStyle(fontSize: 16.sp, color: const Color(0xFF201A21)),
                hinText: "12345mkl",
                controller: confirmPasswordCtrl,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: 30.h),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is SignUpSuccessState) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignIn(),
                        ));
                  }
                },
                builder: (context, state) {
                  return Center(
                    child: PrimaryYellowElevatedButton(
                      displayText: "Ro’yxatdan o’tish",
                      onPressed: () {
                        if (confirmPasswordCtrl.text != passwordCtrl.text) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Parolni takrorlashda xato qildingiz!!!",
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                              ),
                            );
                          }
                          return;
                        }
                        context.read<AuthBloc>().add(
                              SignUpEvent(
                                name: nameCtrl.text,
                                username: usernameCtrl.text,
                                surname: surnameCtrl.text,
                                password: passwordCtrl.text,
                                phoneNumber:
                                    formatPhoneNumber(phoneNumberCtrl.text),
                              ),
                            );
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 15),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Akkauntingiz bormi? ",
                    style: TextStyle(
                      color: Colors.blue,
                      height: 2,
                      decoration: TextDecoration.underline,
                      fontSize: 16.sp,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignIn(),
                          ),
                        );
                      },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
