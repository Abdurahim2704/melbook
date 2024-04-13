import 'dart:core';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:melbook/shared/widgets/app_bar.dart';
import 'package:rxdart/rxdart.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({super.key});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  late AudioPlayer _audioPlayer;

  ///checking
  ///
  ///
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
    _audioPlayer = AudioPlayer()..setAsset("assets/audio/testing.mp3");
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
              const CustomAppBar(
                displayText: "Ingliz tili",
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
                        icon: const Icon(Icons.fullscreen))
                  ],
                ),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30.h,
                ),
                if (!isKaraoke)
                  Center(
                    child: SizedBox(
                      height: 400.h,
                      width: 400.w,
                      child: Image.asset("assets/images/ingliztili.png"),
                    ),
                  ),
                if (isKaraoke)
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.orange)),
                    height: 420.h,
                    child: SingleChildScrollView(
                      child: Text(
                        textAlign: TextAlign.justify,
                        "The high demand for fairy tale books was further facilitated by the emergence of many new publishing houses during the late 19th and early 20th centuries. Then the onset of World War I brought about inflation, leading to resource rationing and a shortage of paper, consequently leading to a reduced book production.[20] The aftermath of the war, later coupled with the Great Depression, further exacerbated the situation, causing a decline in demand for both fairy tales and books in general.[21] A few years later, fairy tales quickly gained popularity again. In 1937, Walt Disney, being aware of the public's desire for an escape from the turmoil of a war-torn and economically strained world, introduced an era of fairy tale movies.and"
                        "being aware of the public's desire for an escape from the turmoil of a war-torn and economically strained world, introduced an era of fairy tale movies.and  ",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                  ),
                SizedBox(
                  height: isKaraoke ? 20.h : 40.h,
                ),
                const Text(
                  "Ingliz tili",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5.h,
                ),
                const Text(
                  "Part 1",
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        _audioPlayer.setAsset("assets/audio/testing.mp3");
                      },
                      icon: const Icon(Icons.repeat),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.skip_previous_rounded)),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.orange,
                          child: Controls(audioPlayer: _audioPlayer),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.skip_next_rounded)),
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
                    // Controls(audioPlayer: _audioPlayer),
                    // const SizedBox(
                    //   width: 5,
                    // ),
                    StreamBuilder<PositionData>(
                      stream: _positionDataStream,
                      builder: (context, snapshot) {
                        final positionData = snapshot.data;
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: ProgressBar(
                              progress: positionData?.position ?? Duration.zero,
                              buffered:
                                  positionData?.bufferPosition ?? Duration.zero,
                              total: positionData?.duration ?? Duration.zero,
                              onSeek: _audioPlayer.seek,
                              barHeight: 4,
                              timeLabelPadding: 8,
                              thumbRadius: 7,
                              thumbGlowRadius: 0.1,
                              timeLabelTextStyle: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                              timeLabelLocation: TimeLabelLocation.above,
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
          ),
        ));
  }
}

class Controls extends StatelessWidget {
  final AudioPlayer audioPlayer;

  const Controls({super.key, required this.audioPlayer});

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
              child: const Icon(Icons.play_arrow_rounded));
        } else if (processingState != ProcessingState.completed) {
          return GestureDetector(
            onTap: audioPlayer.pause,
            child: const Icon(
              Icons.pause_rounded,
              color: Colors.black,
            ),
          );
        }
        return GestureDetector(
          onTap: () {
            audioPlayer.setAsset("assets/audio/testing.mp3");
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
