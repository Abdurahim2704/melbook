import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:melbook/features/home/data/models/notification.dart';
import 'package:melbook/shared/widgets/app_bar.dart';

import '../../../features/auth/domain/repositories/auth_repository.dart';
import '../../../features/home/data/service/notification_service.dart';
import '../../../locator.dart';

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
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator.adaptive(),
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
                padding:
                    EdgeInsets.only(left: 18.0.w, right: 18.w, bottom: 25.h),
                child: Column(
                  children: [
                    Center(
                      child: Image(
                        width: 335.w,
                        height: 180.h,
                        image: NetworkImage(notification.photoUrl),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      notification.title,
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
                          "${notification.date.day}.${notification.date.month}.${notification.date.year}",
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
                          notification.readBy.length.toString(),
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: const Color(0xFFA4A3A4),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      notification.content,
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
      },
    );
  }
}
