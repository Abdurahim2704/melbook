import 'dart:core';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:melbook/features/home/data/models/audio.dart';
import 'package:melbook/features/home/data/models/bookdata.dart';
import 'package:melbook/shared/widgets/app_bar.dart';
import 'package:rxdart/rxdart.dart';

class AudioScreen extends StatefulWidget {
  final String filePath;
  final BookData book;
  final Audio audio;

  const AudioScreen(
      {super.key,
      required this.filePath,
      required this.book,
      required this.audio});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  late AudioPlayer _audioPlayer;

  bool isKaraoke = false;

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _audioPlayer.positionStream,
          _audioPlayer.bufferedPositionStream,
          _audioPlayer.durationStream,
          (position, bufferPosition, duration) => PositionData(
              position, bufferPosition, duration ?? Duration.zero));

  @override
  void initState() {
    _audioPlayer = AudioPlayer()..setFilePath(widget.filePath);
    super.initState();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
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
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, size: 35),
                  ),
                  IconButton(
                    onPressed: () {
                      isKaraoke = !isKaraoke;
                      setState(() {});
                    },
                    icon: const Icon(Icons.fullscreen, size: 35),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30.h,
              ),
              isKaraoke
                  ? Column(
                      children: [
                        SizedBox(height: 80.h),
                        Container(
                          padding: const EdgeInsets.all(13),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.orange),
                          ),
                          height: 520.h,
                          child: SingleChildScrollView(
                            child: Text(
                              textAlign: TextAlign.justify,
                              "The high demand for fairy tale books was further facilitated by the emergence of many new publishing houses during the late 19th and early 20th centuries. Then the onset of World War I brought about inflation, leading to resource rationing and a shortage of paper, consequently leading to a reduced book production.[20] The aftermath of the war, later coupled with the Great Depression, further exacerbated the situation, causing a decline in demand for both fairy tales and books in general.[21] A few years later, fairy tales quickly gained popularity again. In 1937, Walt Disney, being aware of the public's desire for an escape from the turmoil of a war-torn and economically strained world, introduced an era of fairy tale movies.and"
                              "being aware of the public's desire for an escape from the turmoil of a war-torn and economically strained world, introduced an era of fairy tale movies.and  ",
                              style: TextStyle(fontSize: 22.sp),
                            ),
                          ),
                        ),
                        SizedBox(height: 200.h),
                        Text(
                          widget.audio.name,
                          style: TextStyle(
                            fontSize: 21.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          widget.book.author,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                _audioPlayer.setFilePath(widget.filePath);
                              },
                              icon: const Icon(Icons.repeat, size: 30),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.skip_previous_rounded,
                                      size: 35),
                                ),
                                Controls(
                                  audioPlayer: _audioPlayer,
                                  filePath: widget.filePath,
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.skip_next_rounded,
                                      size: 35),
                                ),
                              ],
                            ),
                            IconButton(onPressed: () {}, icon: const SizedBox())
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            StreamBuilder<PositionData>(
                              stream: _positionDataStream,
                              builder: (context, snapshot) {
                                final positionData = snapshot.data;
                                return Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: ProgressBar(
                                      progress: positionData?.position ??
                                          Duration.zero,
                                      buffered: positionData?.bufferPosition ??
                                          Duration.zero,
                                      total: positionData?.duration ??
                                          Duration.zero,
                                      onSeek: _audioPlayer.seek,
                                      barHeight: 5,
                                      timeLabelPadding: 10,
                                      thumbRadius: 10,
                                      thumbGlowRadius: 0.1,
                                      timeLabelTextStyle: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                      timeLabelLocation:
                                      TimeLabelLocation.above,
                                      baseBarColor: Colors.grey,
                                      progressBarColor: Colors.orange,
                                      thumbColor: Colors.orange,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),

                      ],
                    )
                  : Column(
                      children: [
                        SizedBox(height: 180.h),
                        Image(
                          height: 450.h,
                          width: 420.w,
                          fit: BoxFit.fill,
                          image: NetworkImage(widget.book.photoUrl),
                        ),
                        SizedBox(height: 180.h),
                        Text(
                          widget.audio.name,
                          style: TextStyle(
                            fontSize: 21.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          widget.book.author,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                _audioPlayer.setFilePath(widget.filePath);
                              },
                              icon: const Icon(Icons.repeat, size: 30),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.skip_previous_rounded,
                                      size: 35),
                                ),
                                Controls(
                                  audioPlayer: _audioPlayer,
                                  filePath: widget.filePath,
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.skip_next_rounded,
                                      size: 35),
                                ),
                              ],
                            ),
                            IconButton(onPressed: () {}, icon: const SizedBox())
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            StreamBuilder<PositionData>(
                              stream: _positionDataStream,
                              builder: (context, snapshot) {
                                final positionData = snapshot.data;
                                return Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: ProgressBar(
                                      progress: positionData?.position ??
                                          Duration.zero,
                                      buffered: positionData?.bufferPosition ??
                                          Duration.zero,
                                      total: positionData?.duration ??
                                          Duration.zero,
                                      onSeek: _audioPlayer.seek,
                                      barHeight: 5,
                                      timeLabelPadding: 10,
                                      thumbRadius: 10,
                                      thumbGlowRadius: 0.1,
                                      timeLabelTextStyle: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                      timeLabelLocation:
                                          TimeLabelLocation.above,
                                      baseBarColor: Colors.grey,
                                      progressBarColor: Colors.orange,
                                      thumbColor: Colors.orange,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
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

class Controls extends StatelessWidget {
  final AudioPlayer audioPlayer;
  final String filePath;

  const Controls({
    super.key,
    required this.audioPlayer,
    required this.filePath,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: audioPlayer.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;
        if (!(playing ?? false)) {
          return GestureDetector(
            onTap: audioPlayer.play,
            child: const CircleAvatar(
              backgroundColor: Colors.orange,
              radius: 36,
              child: Icon(Icons.play_arrow_rounded, size: 35),
            ),
          );
        } else if (processingState != ProcessingState.completed) {
          return GestureDetector(
            onTap: audioPlayer.pause,
            child: const CircleAvatar(
              backgroundColor: Colors.orange,
              radius: 36,
              child: Icon(
                Icons.pause_rounded,
                color: Colors.black,
                size: 35,
              ),
            ),
          );
        }
        return GestureDetector(
          onTap: () {
            audioPlayer.setFilePath(filePath);
            audioPlayer.play;
          },
          child: const Icon(
            Icons.play_arrow_rounded,
            color: Colors.black,
          ),
        );
      },
    );
  }
}

class PositionData {
  final Duration position;
  final Duration bufferPosition;
  final Duration duration;

  const PositionData(this.position, this.bufferPosition, this.duration);
}
