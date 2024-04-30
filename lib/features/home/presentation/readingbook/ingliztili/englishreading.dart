import 'package:flutter/material.dart';
import 'package:melbook/features/home/data/service/local_audio_service.dart';
import 'package:melbook/features/home/presentation/readingbook/ingliztili/dialog_maker.dart';
import 'package:melbook/features/home/presentation/readingbook/ingliztili/lesson_widget.dart';
import 'package:melbook/features/home/presentation/readingbook/ingliztili/name_player.dart';

import 'finalview.dart';

class IngliztiliReading extends StatefulWidget {
  final Slice slice;
  final int index;
  final List<DialogPairs>? lastText;

  const IngliztiliReading(
      {super.key, required this.slice, this.lastText, required this.index});

  @override
  State<IngliztiliReading> createState() => _IngliztiliReadingState();
}

class _IngliztiliReadingState extends State<IngliztiliReading> {
  @override
  void initState() {
    // print(widget.slice.audios
    //         .map((e) => e.pointCount())
    //         .reduce((value, element) => element + value) +
    //     (widget.slice.remained
    //             ?.map((e) => e.points)
    //             .reduce((value, element) => element + value) ??
    //         0) +
    //     (widget.slice.lastAudio?.pointCount() ?? 0));
    print(widget.index);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: w * 0.03, vertical: h * 0.01),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.slice.remained != null
                    ? DialogMaker(dialogs: widget.slice.remained!)
                    : const SizedBox.shrink(),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final audio = widget.slice.audios[index];
                    return LessonWidget(audio: audio);
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemCount: widget.slice.audios.length,
                ),
                widget.slice.lastAudio != null
                    ? NamePlayer(audio: widget.slice.lastAudio!)
                    : const SizedBox.shrink(),
                widget.lastText != null
                    ? DialogMaker(dialogs: widget.lastText!)
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
