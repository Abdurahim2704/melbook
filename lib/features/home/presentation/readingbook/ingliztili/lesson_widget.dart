import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melbook/features/home/data/service/local_audio_service.dart';
import 'package:melbook/features/home/presentation/readingbook/ingliztili/dialog_maker.dart';

import '../../../../audio/presentation/bloc/player/player_bloc.dart';

class LessonWidget extends StatefulWidget {
  final LocalAudio audio;

  const LessonWidget({super.key, required this.audio});

  @override
  State<LessonWidget> createState() => _LessonWidgetState();
}

class _LessonWidgetState extends State<LessonWidget> {
  String filterAudioName(String title) {
    if (title.contains(r"\")) {
      return title.split(r"\")[1];
    }
    return title;
  }

  String filterLessonName(String title) {
    if (title.contains(r"\")) {
      return title.split(r"\")[0];
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height;
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (filterLessonName(widget.audio.name).isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Center(
                child: Text(
                  filterLessonName(widget.audio.name),
                  softWrap: true,
                  style: TextStyle(
                      fontSize: h * 0.025,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ),
            ),
          Row(
            children: [
              BlocBuilder<PlayerBloc, PlayerState>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () {
                      context.read<PlayerBloc>().add(
                            PlayPause(
                              path: widget.audio.location,
                            ),
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
                          state.isPlaying && state.path == widget.audio.location
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
              const SizedBox(width: 2),
              TextButton(
                child: Text(
                  filterAudioName(widget.audio.name),
                  style: TextStyle(
                    fontSize: h * 0.022,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onPressed: () {
                  context.read<PlayerBloc>().add(
                        PlayPause(
                          path: widget.audio.location,
                        ),
                      );
                },
              ),
            ],
          ),
          DialogMaker(dialogs: widget.audio.description),
        ],
      ),
    );
  }
}
