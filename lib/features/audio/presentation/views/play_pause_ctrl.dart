import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/data/models/audio.dart';
import '../bloc/player/player_bloc.dart';

class Controls extends StatelessWidget {
  final Audio audio;
  final String filePath;

  const Controls({super.key, required this.filePath, required this.audio});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.read<PlayerBloc>().add(PlayPause(path: filePath));
          },
          child: CircleAvatar(
              backgroundColor: Colors.orange,
              radius: 30,
              child: Icon(state.isPlaying
                  ? Icons.pause_rounded
                  : Icons.play_arrow_rounded)),
        );
      },
    );
  }
}
