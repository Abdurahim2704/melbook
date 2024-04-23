import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melbook/features/audio/data/audio_service.dart';
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

  @override
  void deactivate() {
    super.deactivate();
    context.read<PlayerBloc>().add(const PauseAudio());
  }

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
      context.read<LocalStorageBloc>().add(
            DownloadFileAndSave(
                link: nextAudio.audioUrl,
                name: nextAudio.name,
                book: widget.book.name,
                description: nextAudio.content),
          );
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
          book: widget.book.name,
          description: nextAudio.content));
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
  void dispose() {
    super.dispose();
    context.read<PlayerBloc>().add(const PauseAudio());
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
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
                    icon: Icon(Icons.arrow_back, size: 35.sp),
                  ),
                  IconButton(
                    onPressed: () {
                      isKaraoke = !isKaraoke;
                      setState(() {});
                    },
                    icon: Icon(Icons.fullscreen, size: 35.sp),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: isKaraoke ? 64 : 30,
              ),
              if (!isKaraoke)
                Image(
                  height: 720,
                  fit: BoxFit.fitHeight,
                  image: NetworkImage(widget.book.photoUrl),
                ),
              if (isKaraoke)
                Container(
                  height: 720.h,
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.orange),
                  ),
                  child: Scrollbar(
                    thickness: 4,
                    controller: scrollController,
                    interactive: true,
                    thumbVisibility: true,
                    trackVisibility: true,
                    scrollbarOrientation: ScrollbarOrientation.right,
                    child: BlocBuilder<PlayerBloc, PlayerState>(
                      builder: (context, state) {
                        List<String> content = state.audio!.content.split('\n');
                        return ListView.builder(
                          itemCount: content.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.only(bottom: 15.h),
                            child: Text(
                              content[index],
                              style: TextStyle(
                                fontSize: 28.sp,
                                fontWeight: index % 2 == 0
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              SizedBox(
                height: 42.h,
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
                        icon: const Icon(Icons.repeat, size: 35),
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
                                    return GestureDetector(
                                      onTap: () {
                                        final path = context
                                            .read<LocalStorageBloc>()
                                            .state
                                            .audios
                                            .firstWhere(
                                              (element) =>
                                                  element.name ==
                                                  state.audio!.name,
                                            )
                                            .location;
                                        context.read<PlayerBloc>().add(
                                              PlayPause(
                                                path: path,
                                                audio: state.audio!,
                                              ),
                                            );
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.orange,
                                        radius: 40,
                                        child: Icon(
                                          state.isPlaying
                                              ? Icons.pause_rounded
                                              : Icons.play_arrow_rounded,
                                          size: 40,
                                        ),
                                      ),
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
                          : const CircularProgressIndicator.adaptive(),
                      IconButton(onPressed: () {}, icon: const SizedBox())
                    ],
                  );
                },
              ),
              SizedBox(height: 10.h),
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
