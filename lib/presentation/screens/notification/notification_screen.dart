// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:melbook/presentation/screens/notification/notification_detail_screen.dart';
// import 'package:melbook/shared/widgets/app_bar.dart';
//
// class NotificationScreen extends StatelessWidget {
//   const NotificationScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: Size(double.infinity, 90.h),
//         child: Stack(
//           children: [
//             const CustomAppBar(
//               displayText: "Eslatma",
//             ),
//             Align(
//               alignment: Alignment.centerLeft,
//               child: IconButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 icon: SvgPicture.asset(
//                   "assets/icons/ic_back.svg",
//                   height: 26.h,
//                   width: 26.w,
//                 ),
//               ),
//             ),
//             Align(
//               alignment: const Alignment(0.95, 0),
//               child: IconButton(
//                 onPressed: () {},
//                 icon: SvgPicture.asset(
//                   "assets/icons/ic_notification_done.svg",
//                   height: 22.h,
//                   width: 22.w,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: ListView.separated(
//         itemCount: 10,
//         padding: EdgeInsets.only(
//           left: 12.w,
//           right: 12.w,
//           bottom: 20.h,
//         ),
//         separatorBuilder: (context, index) => SizedBox(height: 12.h),
//         itemBuilder: (context, index) {
//           return ListTile(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const NotificationDetailScreen(),
//                 ),
//               );
//             },
//             shape: const ContinuousRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(20)),
//               side: BorderSide(
//                 color: Color(0xFFE7E7E7),
//               ),
//             ),
//             minLeadingWidth: 80,
//             leading: Transform.scale(
//               scaleY: 1.3,
//               scaleX: 1.3,
//               child: Image(
//                 height: 60.h,
//                 width: 60.w,
//                 image: const AssetImage(
//                   "assets/images/img_notification_tile.png",
//                 ),
//               ),
//             ),
//             title: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Melbook kitoblariga 50% chegirmaga shoshiling",
//                   style: TextStyle(
//                     fontSize: 15.sp,
//                     fontWeight: FontWeight.w600,
//                     color: const Color(0xFF000000),
//                   ),
//                   maxLines: 2,
//                 ),
//                 SizedBox(height: 7.h),
//                 Row(
//                   children: [
//                     SvgPicture.asset(
//                       "assets/icons/ic_calendar_notification.svg",
//                       height: 16.h,
//                       width: 16.w,
//                     ),
//                     SizedBox(width: 8.w),
//                     Text(
//                       "21.03.2024",
//                       style: TextStyle(
//                         fontSize: 10.sp,
//                         color: const Color(0xFFA4A3A4),
//                       ),
//                     ),
//                     SizedBox(width: 50.w),
//                     SvgPicture.asset(
//                       "assets/icons/ic_view.svg",
//                       height: 15.h,
//                       width: 15.w,
//                     ),
//                     SizedBox(width: 5.w),
//                     Text(
//                       "5 700",
//                       style: TextStyle(
//                         fontSize: 10.sp,
//                         color: const Color(0xFFA4A3A4),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:melbook/presentation/screens/notification/notification_detail_screen.dart';
import 'package:melbook/features/home/data/models/notification.dart' as notif;

import '../../../features/home/data/service/notification_service.dart';
import '../../../shared/widgets/app_bar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<List<notif.Notification>> _notificationFuture;

  @override
  void initState() {
    super.initState();
    _notificationFuture = NotificationService().getAllNotifications();
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
      body: FutureBuilder<List<notif.Notification>>(
        future: _notificationFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No notifications available.'),
            );
          } else {
            return ListView.separated(
              itemCount: snapshot.data!.length,
              padding: EdgeInsets.only(
                left: 12.w,
                right: 12.w,
                bottom: 20.h,
              ),
              separatorBuilder: (context, index) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                final notification = snapshot.data![index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificationDetailScreen(),
                      ),
                    );
                  },
                  shape: const ContinuousRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    side: BorderSide(
                      color: Color(0xFFE7E7E7),
                    ),
                  ),
                  minLeadingWidth: 80,
                  leading: Transform.scale(
                    scaleY: 1.3,
                    scaleX: 1.3,
                    child: Image(
                      height: 60.h,
                      width: 60.w,
                      image: AssetImage(
                        "assets/images/img_notification_tile.png",
                      ),
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.title,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF000000),
                        ),
                        maxLines: 2,
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
                );
              },
            );
          }
        },
      ),
    );
  }
}
