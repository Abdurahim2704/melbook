import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:melbook/features/audio/presentation/audio.dart';
import 'package:melbook/features/home/data/models/bookdata.dart';
import 'package:melbook/features/home/presentation/bloc/local_storage/local_storage_bloc.dart';

class ContainerAudiosListening extends StatefulWidget {
  final BookData bookData;

  const ContainerAudiosListening({super.key, required this.bookData});

  @override
  State<ContainerAudiosListening> createState() =>
      _ContainerAudiosListeningState();
}

class _ContainerAudiosListeningState extends State<ContainerAudiosListening> {
  @override
  void initState() {
    super.initState();
    context.read<LocalStorageBloc>().stream.listen((event) {
      if (event is DownloadSuccess) {
        print("I am here");
        print(event.audios);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalStorageBloc, LocalStorageState>(
      builder: (context, state) {
        return ListView.builder(
          padding: EdgeInsets.only(bottom: 10.h, left: 12.w, right: 12.w),
          itemCount: widget.bookData.audios?.length,
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
                      imageUrl: widget.bookData.photoUrl,
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
                              widget.bookData.audios?[index].name ?? "",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AudioScreen(
                                          filePath: state.audios.firstWhere(
                                              (element) => (element["name"] ==
                                                  widget.bookData.audios![index]
                                                      .name))["location"],
                                        ),
                                      ));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(6.sp),
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
                                onTap: () {
                                  print(state.audios);
                                  print(state.audios
                                      .map((e) => e["name"])
                                      .toList());
                                  context.read<LocalStorageBloc>().add(
                                        DownloadFileAndSave(
                                          link: widget
                                              .bookData.audios![index].audioUrl,
                                          name: widget
                                              .bookData.audios![index].name,
                                          book: widget.bookData.name,
                                        ),
                                      );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(6.sp),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFFF2F2F2),
                                  ),
                                  child: state.audios
                                          .map((e) => e["name"])
                                          .toList()
                                          .contains(widget
                                              .bookData.audios![index].name)
                                      ? const Icon(Icons.check)
                                      : SvgPicture.asset(
                                          "assets/icons/ic_saved.svg",
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
      },
    );
  }
}
