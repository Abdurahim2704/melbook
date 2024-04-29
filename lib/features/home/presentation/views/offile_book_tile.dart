import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melbook/features/home/data/models/local_book.dart';
import 'package:melbook/features/home/presentation/saved/offline_reading_page.dart';

class OfflineBookTile extends StatelessWidget {
  final LocalBook book;

  const OfflineBookTile({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OfflineReadingPage(book: book),
          ),
        );
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 18.h),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: CupertinoColors.systemGroupedBackground,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: book.name,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  "assets/images/ingliztili.png",
                  height: 250.h,
                ),
              ),
            ),
            SizedBox(width: 20.w),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 60.h),
                  Text(
                    book.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.orange.shade800,
                      fontSize: 23.sp,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    "O'qish",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 28.sp,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
