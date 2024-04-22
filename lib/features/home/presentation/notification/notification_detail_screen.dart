import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:melbook/features/home/data/models/notification.dart';
import 'package:melbook/shared/widgets/app_bar.dart';

import '../../../../locator.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../data/service/notification_service.dart';

class NotificationDetailScreen extends StatefulWidget {
  final String notificationId;

  const NotificationDetailScreen({required this.notificationId, super.key});

  @override
  State<NotificationDetailScreen> createState() =>
      _NotificationDetailScreenState();
}

class _NotificationDetailScreenState extends State<NotificationDetailScreen> {
  late Future<NotificationModel> _notificationFuture;

  @override
  void initState() {
    super.initState();
    _notificationFuture = NotificationService().markNotificationAsRead(
      notificationId: widget.notificationId,
      token: getIt<AuthRepository>().token,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NotificationModel>(
      future: _notificationFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Lottie.asset(
                "assets/lottie/loading_animation.json",
                height: 145.h,
                width: 145.w,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('No Details available'),
          );
        } else {
          final notification = snapshot.data!;
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
                        height: 35.h,
                        width: 35.w,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 18.0.w,
                  right: 18.w,
                  bottom: 25.h,
                  top: 20.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ClipRRect(
                        clipBehavior: Clip.antiAlias,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        child: Image(
                          width: 500.w,
                          height: 280.h,
                          fit: BoxFit.fitWidth,
                          image: NetworkImage(notification.photoUrl),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Center(
                      child: Text(
                        notification.title,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF000000),
                        ),
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    const Divider(
                      color: Color(0xFFE6E6E6),
                      thickness: 1,
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/ic_calendar_notification.svg",
                          height: 22.h,
                          width: 22.w,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          "${notification.date.day}.${notification.date.month}.${notification.date.year}",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: const Color(0xFFA4A3A4),
                          ),
                        ),
                        const Spacer(),
                        SvgPicture.asset(
                          "assets/icons/ic_view.svg",
                          height: 21.h,
                          width: 21.w,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          notification.readBy.length.toString(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: const Color(0xFFA4A3A4),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      notification.content,
                      style: TextStyle(
                        fontSize: 23.sp,
                        color: const Color(0xFF201A21),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
