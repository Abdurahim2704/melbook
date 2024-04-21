import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melbook/features/home/data/models/bookdata.dart';

import '../../../audio/presentation/audio.dart';
import '../../../audio/presentation/bloc/player/player_bloc.dart';
import '../../data/models/audio.dart';
import '../../data/service/local_audio_service.dart';
import '../bloc/local_storage/local_storage_bloc.dart';

class OnlineListTile extends StatefulWidget {
  final BookData bookData;
  final Audio currentAudio;
  final int index;

  const OnlineListTile(
      {super.key,
      required this.bookData,
      required this.currentAudio,
      required this.index});

  @override
  State<OnlineListTile> createState() => _OnlineListTileState();
}

class _OnlineListTileState extends State<OnlineListTile> {
  void goAudioPage(BuildContext context, List<LocalAudio> audios, int index) {
    context
        .read<PlayerBloc>()
        .add(InitAudio(audio: widget.bookData.audios![index]));
    print(context.read<PlayerBloc>().state.audio?.name);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AudioScreen(
          filePath: audios
              .firstWhere((element) =>
                  (element.name == widget.bookData.audios![index].name))
              .location,
          book: widget.bookData,
        ),
      ),
    );
  }

  void _playButton(int index, List<LocalAudio> audios) {
    audios.map((e) => e.name).contains(widget.bookData.audios![index].name)
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
              child: CachedNetworkImage(
                imageUrl: widget.bookData.photoUrl,
                width: 170.w,
                height: 170.h,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(width: 30.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      widget.currentAudio.name ?? "",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  BlocBuilder<LocalStorageBloc, LocalStorageState>(
                    builder: (context, state) {
                      return (state is DownloadWaiting &&
                              (state.downloadingAudio ?? "") ==
                                  widget.currentAudio.name)
                          ? const CircularProgressIndicator.adaptive()
                          : Row(
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
                                BlocBuilder<LocalStorageBloc,
                                    LocalStorageState>(
                                  builder: (context, state) {
                                    return GestureDetector(
                                      onTap: () {
                                        if (!state.audios
                                            .map((e) => e.name)
                                            .contains(widget.bookData
                                                .audios![widget.index].name)) {
                                          context.read<LocalStorageBloc>().add(
                                                DownloadFileAndSave(
                                                    link: widget
                                                        .bookData
                                                        .audios![widget.index]
                                                        .audioUrl,
                                                    name: widget
                                                        .bookData
                                                        .audios![widget.index]
                                                        .name,
                                                    book: widget.bookData.name,
                                                    description: widget
                                                        .bookData
                                                        .audios![widget.index]
                                                        .content),
                                              );
                                        }
                                      },
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
                                                .contains(widget.bookData
                                                    .audios![widget.index].name)
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
