// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:melbook/features/home/data/models/bookdata.dart';
// import 'package:melbook/features/home/presentation/ingliztilipage.dart';
//
// class BookTile extends StatelessWidget {
//   final BookData book;
//
//   const BookTile({super.key, required this.book});
//
//   @override
//   Widget build(BuildContext context) {
//     List<String> images = [
//       "assets/images/ingliztili.png",
//       "assets/images/rustili.jpg",
//       "assets/images/arabtili.jpg",
//       "assets/images/koreystili.jpg",
//     ];
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => Ingliztilipage(book: book),
//           ),
//         );
//       },
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 12.h),
//         padding: EdgeInsets.symmetric(horizontal: 1.w),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Column(
//           children: [
//             for (int i = 0; i < images.length; i++)
//               Image(
//                 image: AssetImage(images[i]),
//                 width: 290.w,
//                 height: 330.h,
//                 fit: BoxFit.fitWidth,
//               ),
//             SizedBox(height: 15.h),
//             Column(
//               children: [
//                 Text(
//                   book.name,
//                   style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 15.sp,
//                   ),
//                 ),
//                 SizedBox(height: 15.h),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => Ingliztilipage(book: book),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     alignment: Alignment.center,
//                     height: 40.h,
//                     width: 40.w,
//                     padding: EdgeInsets.only(
//                       top: 6.sp,
//                       left: 7.sp,
//                       right: 7.sp,
//                       bottom: 9.sp,
//                     ),
//                     decoration: const BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Color(0xFFF2F2F2),
//                     ),
//                     child: Icon(
//                       size: 16.sp,
//                       Icons.play_arrow,
//                       color: Colors.black,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
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

      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Ingliztilipage(book: book),
          ),
        );
      },
      child: SizedBox(
        height: 260.h,
        child: Card(
          color: Colors.white,
          child: Row(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    width: 250.w,
                    height: 250.h, imageUrl: imagePath,
                  ),
                ),
              ),
              SizedBox(width: 20.w),
              Column(mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.orange.shade800,
                    ),
                  ),
                  SizedBox(
                    width: 300.w,
                    child: Text(
                      book.author,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.orange.shade600,
                      ),
                    ),
                  ),
                  Text(
                    book.bought? "Sotib olingan" : "Sotib olinmagan",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 30.sp,
                      color: book.bought ? Colors.green : Colors.red,
                    ),
                  ),
                  SizedBox(height: 15,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
