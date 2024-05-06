import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melbook/features/home/data/service/local_audio_service.dart';

import '../../../../audio/presentation/bloc/player/player_bloc.dart';

class NamePlayer extends StatelessWidget {
  final LocalAudio audio;

  const NamePlayer({super.key, required this.audio});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height;
    return Row(
      children: [
        if (audio.location != "no audio")
          BlocBuilder<PlayerBloc, PlayerState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  context.read<PlayerBloc>().add(
                        PlayPause(path: audio.location),
                      );
                },
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 3, color: Colors.black),
                  ),
                  child: Center(
                    child: Icon(
                      state.isPlaying && state.path == audio.location
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      color: Colors.black,
                      size: h * 0.025,
                    ),
                  ),
                ),
              );
            },
          ),

        if (audio.location == "no audio")
        Text(
          audio.name,
          style: TextStyle(fontSize: h * 0.022, fontWeight: FontWeight.w700),
        ),
        const SizedBox(width: 2),
        if (audio.location != "no audio")
          Flexible(
            child: TextButton(
              child: Text(
                audio.name,
                style: TextStyle(
                  fontSize: h * 0.022,
                  fontWeight: FontWeight.w700,
                ),
              ),
              onPressed: () {
                context.read<PlayerBloc>().add(
                      PlayPause(
                        path: audio.location,
                      ),
                    );
              },
            ),
          ),
      ],
    );
  }
}
