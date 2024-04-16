import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melbook/features/home/data/models/bookdata.dart';
import 'package:melbook/features/home/presentation/ingliztilipage.dart';

class BookContainer extends StatelessWidget {
  final BookData bookData;

  const BookContainer({super.key, required this.bookData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Ingliztilipage(
                book: bookData,
              ),
            ));
      },
      child: Container(
        height: 200.h,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
            borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            ClipRRect(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              child: CachedNetworkImage(
                imageUrl: bookData.photoUrl,
                width: 170.w,
                height: 190.h,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      bookData.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 24.sp,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    alignment: Alignment.center,
                    height: 35.h,
                    width: 160.w,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Text(
                      bookData.bought ? "O'qish" : "Sotib olish",
                      style:  TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 40.h,
                width: 40.w,
                padding: EdgeInsets.all(7.sp),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
