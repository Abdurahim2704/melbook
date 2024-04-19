import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/service/local_audio_service.dart';
import '../bloc/local_storage/local_storage_bloc.dart';

class OfflineListTile extends StatefulWidget {
  final List<LocalAudio> audios;
  final int index;

  const OfflineListTile({super.key, required this.audios, required this.index});

  @override
  State<OfflineListTile> createState() => _OfflineListTileState();
}

class _OfflineListTileState extends State<OfflineListTile> {
  void goAudioPage(BuildContext context, List<LocalAudio> audios, int index) {
    // context
    //     .read<PlayerBloc>()
    //     .add(InitAudioOffline(audio: ));
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => AudioScreen(
    //       filePath: audio.location,
    //       book: widget.bookData,
    //
    //     ),
    //   ),
    // );
  }

  void _playButton(int index, List<LocalAudio> audios) {
    audios.map((e) => e.name).contains(widget.audios[index].name)
        ? goAudioPage(context, audios, index)
        : showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                elevation: 0,
                backgroundColor: Colors.white,
                title: Center(
                  child: Text(
                    "Audioni avval yuklab oling!",
                    style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Ok"),
                  ),
                ],
              );
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 180.h,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            ClipRRect(
              clipBehavior: Clip.antiAlias,
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
              child: Icon(Icons.near_me),
            ),
            SizedBox(width: 30.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      widget.audios[widget.index].name ?? "",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  BlocBuilder<LocalStorageBloc, LocalStorageState>(
                    builder: (context, state) {
                      return Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _playButton(widget.index, state.audios);
                            },
                            child: Container(
                              height: 55.h,
                              width: 55.w,
                              padding: EdgeInsets.all(6.sp),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFF2F2F2),
                              ),
                              child: const Icon(
                                Icons.play_arrow,
                                size: 28,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(width: 22.w),
                          BlocBuilder<LocalStorageBloc, LocalStorageState>(
                            builder: (context, state) {
                              return GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: 55.h,
                                  width: 55.w,
                                  padding: EdgeInsets.all(6.sp),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFFF2F2F2),
                                  ),
                                  child: state.audios
                                          .map((e) => e.name)
                                          .toList()
                                          .contains(
                                              widget.audios[widget.index].name)
                                      ? const Icon(Icons.check, size: 28)
                                      : const Icon(
                                          Icons.cloud_download,
                                          size: 28,
                                        ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
