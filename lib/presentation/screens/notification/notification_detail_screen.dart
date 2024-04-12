import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:melbook/shared/widgets/app_bar.dart';

class NotificationDetailScreen extends StatelessWidget {
  const NotificationDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 90.h),
        child: Stack(
          children: [
            const CustomAppBar(
              displayText: "Eslatma",
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: SvgPicture.asset(
                  "assets/icons/ic_back.svg",
                  height: 26.h,
                  width: 26.w,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 18.0.w, right: 18.w, bottom: 25.h),
          child: Column(
            children: [
              Center(
                child: Image(
                  width: 335.w,
                  height: 180.h,
                  image: const AssetImage(
                    "assets/images/img_notification_detail.png",
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "Melbook kitoblariga 50% chegirmaga shoshiling",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF000000),
                ),
                maxLines: 2,
              ),
              SizedBox(height: 10.h),
              const Divider(
                color: Color(0xFFE6E6E6),
                thickness: 1,
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/ic_calendar_notification.svg",
                    height: 16.h,
                    width: 16.w,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    "21.03.2024",
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: const Color(0xFFA4A3A4),
                    ),
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    "assets/icons/ic_view.svg",
                    height: 15.h,
                    width: 15.w,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    "5 700",
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: const Color(0xFFA4A3A4),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Text(
                "The high demand for fairy tale books was further facilitated by the emergence of many new publishing houses during the late 19th and early 20th centuries. Then the onset of World War I brought about inflation, leading to resource rationing and a shortage of paper, consequently leading to a reduced book production.[20] The aftermath of the war, later coupled with the Great Depression, further exacerbated the situation, causing a decline in demand for both fexacerbated the situation, causing a decline in demand for both fexacerbated the situation, causing a decline in demand for both fexacerbated the something in ordinary looks because of some unordinary criterias further exacerbated the situation, causing a decline in demand for both fexacerbated the situation, causing a decline in demand for both fexacerbated the situation, causing a decline in demand for both fexacerbated the something in ordinary looks because of some unordinary criterias.",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: const Color(0xFF201A21),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
