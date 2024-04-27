import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melbook/features/home/data/models/bookdata.dart';
import 'package:melbook/features/home/presentation/ingliztilipage.dart';

class BookTile extends StatelessWidget {
  final String imagePath;
  final BookData book;

  const BookTile({
    super.key,
    required this.book,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Ingliztilipage(book: book),
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
              tag: book.id,
              child: Transform.scale(
                scaleY: 2.w,
                scaleX: 2.h,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CachedNetworkImage(
                    height: 250.h,
                    imageUrl: imagePath,
                  ),
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
                    book.bought ? "Sotib olingan" : "Sotib olinmagan",
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
