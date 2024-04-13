import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melbook/shared/widgets/app_bar.dart';
import 'package:melbook/shared/widgets/auth_textfield.dart';
import 'package:melbook/shared/widgets/auth_textfield_header.dart';
import 'package:melbook/shared/widgets/custom_alert_dialog.dart';
import 'package:melbook/shared/widgets/primary_yellow_elevated_button.dart';

class CodeAuthScreen extends StatefulWidget {
  const CodeAuthScreen({super.key});

  @override
  State<CodeAuthScreen> createState() => _CodeAuthScreenState();
}

class _CodeAuthScreenState extends State<CodeAuthScreen> {
  bool timeout = false;
  String otp = "";

  Stream<int> secundomer(int seconds) async* {
    if (seconds <= 0) {
      return;
    }

    await Future.delayed(const Duration(seconds: 1));
    yield seconds;
    yield* secundomer(seconds - 1);
  }

  TextEditingController controller = TextEditingController();
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
            AuthTextField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              maxLength: 6,
              style: TextStyle(
                height: 1,
                fontSize: 28.sp,
                letterSpacing: 30,
                color: const Color(0xFF000000),
                fontWeight: FontWeight.w600,
              ), controller: controller,
            ),
            SizedBox(height: 30.h),
            Center(child: buildTextFieldHeaderText("Kod kelmadimi?")),
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Kodni qayta yuborish",
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: const Color(0xFF000000),
                  ),
                ),
                const SizedBox(width: 10),
                StreamBuilder(
                  stream: secundomer(60),
                  initialData: 60,
                  builder: (context, snapshot) {
                    final data = snapshot.data!;
                    final second = (data % 60).toString();
                    if (data > 1) {
                      timeout = false;
                      return Text(
                        second,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFFF6BE07),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          height: 0.07,
                        ),
                      );
                    }

                    return IconButton(
                      onPressed: () {
                        timeout = true;
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.replay_rounded,
                        color: Color(0xFFF6BE07),
                      ),
                    );
                  },
                ),
              ],
            ),
            const Spacer(),
            PrimaryYellowElevatedButton(
              displayText: "Davom etish",
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) {
                    return CustomAlertDialog(
                      displayText: "Kartangiz qo’shildi",
                      onPressed: () {
                        Navigator.pop(context); // Dialogni berkitadi
                        Navigator.pop(context); // HomePagega navigate qiladi
                      },
                    );
                  },
                );
              },
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
