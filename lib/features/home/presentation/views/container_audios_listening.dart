import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:melbook/features/home/data/models/bookdata.dart';

class ContainerAudiosListening extends StatelessWidget {
  final BookData bookData;

  const ContainerAudiosListening({super.key, required this.bookData});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 10.h, left: 12.w, right: 12.w),
      itemCount: bookData.audios?.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            height: 114.h,
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: bookData.photoUrl,
                  width: 73.w,
                  height: 104.h,
                  fit: BoxFit.fill,
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          bookData.audios?[index].name ?? "",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFF2F2F2),
                              ),
                              child: const Icon(
                                Icons.play_arrow,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(width: 22.w),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFF2F2F2),
                              ),
                              child: SvgPicture.asset(
                                "assets/icons/ic_saved.svg",
                                height: 22.h,
                                width: 22.w,
                              ),
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
}