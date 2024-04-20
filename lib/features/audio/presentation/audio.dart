import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melbook/features/audio/data/audio_service.dart';
import 'package:melbook/features/audio/presentation/views/play_pause_ctrl.dart';
import 'package:melbook/features/audio/presentation/views/progress_bar.dart';
import 'package:melbook/features/home/data/models/bookdata.dart';
import 'package:melbook/features/home/presentation/bloc/local_storage/local_storage_bloc.dart';
import 'package:melbook/shared/widgets/app_bar.dart';

import 'bloc/player/player_bloc.dart';

class AudioScreen extends StatefulWidget {
  final String filePath;
  final BookData book;

  const AudioScreen({
    super.key,
    required this.filePath,
    required this.book,
  });

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  bool isKaraoke = false;

  void goNext() {
    final currentAudio = context.read<PlayerBloc>().state.audio!;
    final nextAudioIndex = (widget.book.audios!.indexOf(currentAudio) + 1) %
        (widget.book.audios!.length);
    final nextAudio = widget.book.audios![nextAudioIndex];
    if (context
        .read<LocalStorageBloc>()
        .state
        .audios
        .map((e) => e.name)
        .contains(nextAudio.name)) {
      final nextPath = context
          .read<LocalStorageBloc>()
          .state
          .audios
          .firstWhere((element) => element.name == nextAudio.name)
          .location;
      print("Salom: ${nextAudio.name}");
      context
          .read<PlayerBloc>()
          .add(SkipNext(path: nextPath, audio: nextAudio));
    } else {
      context.read<LocalStorageBloc>().add(DownloadFileAndSave(
          link: nextAudio.audioUrl,
          name: nextAudio.name,
          book: widget.book.name));
      context.read<LocalStorageBloc>().stream.listen((event) {
        if (event is DownloadSuccess) {
          final nextPath = context
              .read<LocalStorageBloc>()
              .state
              .audios
              .firstWhere((element) => element.name == nextAudio.name)
              .location;
          context
              .read<PlayerBloc>()
              .add(SkipNext(path: nextPath, audio: nextAudio));
        }
      });
    }
  }

  void goPrevious() {
    final currentAudio = context.read<PlayerBloc>().state.audio!;
    int previousAudioIndex = (widget.book.audios!.indexOf(currentAudio) - 1);
    if (previousAudioIndex < 0) {
      previousAudioIndex =
          widget.book.audios!.length - previousAudioIndex.abs();
    }
    final nextAudio = widget.book.audios![previousAudioIndex];
    if (context
        .read<LocalStorageBloc>()
        .state
        .audios
        .map((e) => e.name)
        .contains(nextAudio.name)) {
      final nextPath = context
          .read<LocalStorageBloc>()
          .state
          .audios
          .firstWhere((element) => element.name == nextAudio.name)
          .location;
      context
          .read<PlayerBloc>()
          .add(SkipNext(path: nextPath, audio: nextAudio));
    } else {
      context.read<LocalStorageBloc>().add(DownloadFileAndSave(
          link: nextAudio.audioUrl,
          name: nextAudio.name,
          book: widget.book.name));
      context.read<LocalStorageBloc>().stream.listen((event) {
        if (event is DownloadSuccess) {
          final nextPath = context
              .read<LocalStorageBloc>()
              .state
              .audios
              .firstWhere((element) => element.name == nextAudio.name)
              .location;
          context
              .read<PlayerBloc>()
              .add(SkipNext(path: nextPath, audio: nextAudio));
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    print(context.read<PlayerBloc>().state.audio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 80.w),
        child: Stack(
          children: [
            CustomAppBar(
              displayText: widget.book.name,
            ),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BackButton(),
                  IconButton(
                    onPressed: () {
                      isKaraoke = !isKaraoke;
                      setState(() {});
                    },
                    icon: const Icon(Icons.fullscreen),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              if (!isKaraoke)
                Image(
                  height: 800,
                  fit: BoxFit.fill,
                  image: NetworkImage(widget.book.photoUrl),
                ),
              // if (isKaraoke)
              //   Container(
              //     padding: const EdgeInsets.all(10),
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(12),
              //         border: Border.all(color: Colors.orange)),
              //     child: SingleChildScrollView(
              //       child: Text(
              //         textAlign: TextAlign.justify,
              //         "The high demand for fairy tale books was further facilitated by the emergence of many new publishing houses during the late 19th and early 20th centuries. Then the onset of World War I brought about inflation, leading to resource rationing and a shortage of paper, consequently leading to a reduced book production.[20] The aftermath of the war, later coupled with the Great Depression, further exacerbated the situation, causing a decline in demand for both fairy tales and books in general.[21] A few years later, fairy tales quickly gained popularity again. In 1937, Walt Disney, being aware of the public's desire for an escape from the turmoil of a war-torn and economically strained world, introduced an era of fairy tale movies.and"
              //         "being aware of the public's desire for an escape from the turmoil of a war-torn and economically strained world, introduced an era of fairy tale movies.and  ",
              //         style: TextStyle(fontSize: 14.sp),
              //       ),
              //     ),
              //   ),
              SizedBox(
                height: isKaraoke ? 20 : 70,
              ),
              BlocBuilder<PlayerBloc, PlayerState>(
                builder: (context, state) {
                  return Text(
                    state.audio!.name,
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                widget.book.author,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 26.sp,
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              BlocBuilder<LocalStorageBloc, LocalStorageState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.repeat),
                      ),
                      state is! DownloadWaiting
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: goPrevious,
                                  icon: const Icon(
                                    Icons.skip_previous_rounded,
                                    size: 40,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                BlocBuilder<PlayerBloc, PlayerState>(
                                  builder: (context, state) {
                                    return Controls(
                                      filePath: widget.filePath,
                                      audio: state.audio!,
                                    );
                                  },
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                BlocBuilder<PlayerBloc, PlayerState>(
                                  builder: (context, state) {
                                    return IconButton(
                                      onPressed: goNext,
                                      icon: const Icon(
                                        Icons.skip_next_rounded,
                                        size: 40,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            )
                          : CircularProgressIndicator.adaptive(),
                      IconButton(onPressed: () {}, icon: const SizedBox())
                    ],
                  );
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  StreamBuilder<Duration>(
                    stream: AudioServiceImpl.audioDuration(),
                    builder: (context, snapshot) {
                      final positionData =
                          snapshot.data ?? const Duration(seconds: 0);
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: CustomProgressBar(
                            positionData: positionData,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
