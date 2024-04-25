import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: [
            BlocBuilder<PlayerBloc, PlayerState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    context.read<PlayerBloc>().add(PlayPause(
                          path: widget.audio.location,
                        ));
                  },
                  child: Container(
                    padding: EdgeInsets.all(2.5.sp),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 3, color: Colors.black)),
                    child: Center(
                      child: Icon(
                        state.isPlaying && state.path == widget.audio.location
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        color: Colors.black,
                        size: 11.sp,
                      ),
                    ),
                  ),
                );
              },
            ),
            TextButton(
              child: Text(widget.audio.name,
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700)),
              onPressed: () {
                context.read<PlayerBloc>().add(PlayPause(
                      path: widget.audio.location,
                    ));
              },
            ),
          ],
        ),
        DialogMaker(dialogs: widget.audio.description),
      ],
    );
  }
}
