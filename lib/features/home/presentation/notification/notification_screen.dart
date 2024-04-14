import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:melbook/features/home/data/models/notification.dart' as notif;
import 'package:melbook/locator.dart';

import '../../../../shared/widgets/app_bar.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../data/service/notification_service.dart';
import 'notification_detail_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<List<notif.NotificationModel>> _notificationFuture;

  @override
  void initState() {
    super.initState();
    _notificationFuture = NotificationService().getAllNotifications(
      token: getIt<AuthRepository>().token,
    );
  }

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
            Align(
              alignment: const Alignment(0.95, 0),
              child: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  "assets/icons/ic_notification_done.svg",
                  height: 22.h,
                  width: 22.w,
                ),
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<notif.NotificationModel>>(
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
          } else if (snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No notifications available',
              ),
            );
          } else {
            return ListView.separated(
              itemCount: snapshot.data!.length,
              padding: EdgeInsets.only(
                left: 12.w,
                right: 12.w,
                bottom: 20.h,
              ),
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemBuilder: (context, index) {
                final notification = snapshot.data![index];
                return SizedBox(
                  height: 90.h,
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotificationDetailScreen(
                            notificationId: notification.id,
                          ),
                        ),
                      );
                    },
                    shape: const ContinuousRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      side: BorderSide(
                        color: Color(0xFFE7E7E7),
                      ),
                    ),
                    title: Row(
                      children: [
                        Transform.translate(
                          offset: Offset(-9.5.w, -7.h),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              notification.photoUrl,
                              height: 72.h,
                              width: 72.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notification.title,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF000000),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 7.h),
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
                                  SizedBox(width: 50.w),
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
