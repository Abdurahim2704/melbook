import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:melbook/features/auth/data/service/local_service.dart';
import 'package:melbook/features/auth/presentation/sign_up.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<String> titles = [
    "Chet tillarini biz bilan qulay tarzda o’rganing ",
    "Qiziqarli kitoblar va audiolar orqali bilimingizni oshiring",
    "Hoziroq ro’yxatdan o’ting va barchasiga tezroq erishing!"
  ];
  List<String> imgPath = [
    "assets/images/img_intro1.png",
    "assets/images/img_intro2.png",
    "assets/images/img_intro3.png",
  ];

  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    LocalDBService.setShowIntro(false);
    return Scaffold(
      backgroundColor: const Color(0xff201A21),
      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          for (int i = 0; i < 3; i++)
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.asset(
                  imgPath[i],
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: 270.h,
                  width: double.infinity,
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    children: [
                       SizedBox(
                        height: 60.h,
                      ),
                      Text(
                        titles[i],
                        style:
                             TextStyle(color: Colors.white, fontSize: 14.sp),
                        textAlign: TextAlign.center,
                      ),
                       SizedBox(
                        height: 20.h,
                      ),
                      SizedBox(
                        height: 94.h,
                        width: 94.h,
                        child: CustomPaint(
                          size:  Size(94.h, 94.h),
                          painter: IntroPainter(currentPage: i),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: GestureDetector(
                              onTap: () {
                                i != 2
                                    ? controller.animateToPage(i + 1,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.fastOutSlowIn)
                                    : Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const SignUp(),
                                        ),
                                        (route) => false);
                                setState(() {});
                              },
                              child:
                                  SvgPicture.asset("assets/icons/ic_intro.svg"),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
        ],
      ),
    );
  }
}

class IntroPainter extends CustomPainter {
  int currentPage;

  IntroPainter({required this.currentPage});

  @override
  void paint(Canvas canvas, Size size) {
    double height = size.height;
    double width = size.width;
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    Path path = Path()
      ..arcTo(
          Rect.fromCircle(
              center: Offset(width / 2, height / 2), radius: size.height / 2),
          0,
          pi / 1.505 + currentPage * pi / 1.505,
          false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate != this;
}
