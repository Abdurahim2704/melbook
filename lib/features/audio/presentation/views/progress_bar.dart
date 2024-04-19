import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/audio_service.dart';
import '../bloc/player/player_bloc.dart';

class CustomProgressBar extends StatelessWidget {
  final Duration positionData;

  const CustomProgressBar({super.key, required this.positionData});

  @override
  Widget build(BuildContext context) {
    return ProgressBar(
      progress: positionData,
      total: AudioServiceImpl.totalDuration(),
      onSeek: (value) {
        context.read<PlayerBloc>().add(SeekPosition(position: value));
      },
      barHeight: 4,
      timeLabelPadding: 8,
      thumbRadius: 7,
      thumbGlowRadius: 0.1,
      timeLabelTextStyle: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      timeLabelLocation: TimeLabelLocation.above,
      baseBarColor: Colors.grey,
      progressBarColor: Colors.orange,
      thumbColor: Colors.orange,
    );
  }
}
