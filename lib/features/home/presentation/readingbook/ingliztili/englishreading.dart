import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melbook/features/home/data/service/local_audio_service.dart';
import 'package:melbook/features/home/presentation/readingbook/ingliztili/dialog_maker.dart';
import 'package:melbook/features/home/presentation/readingbook/ingliztili/lesson_widget.dart';
import 'package:melbook/features/home/presentation/readingbook/ingliztili/name_player.dart';

import 'finalview.dart';

class IngliztiliReading extends StatefulWidget {
  final Slice slice;
  final List<DialogPairs>? lastText;

  const IngliztiliReading({super.key, required this.slice, this.lastText});

  @override
  State<IngliztiliReading> createState() => _IngliztiliReadingState();
}

class _IngliztiliReadingState extends State<IngliztiliReading> {
  final double horPadding = 30;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(360, 690),
      minTextAdapt: true,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horPadding),
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
                  separatorBuilder: (context, index) => SizedBox(
                    height: 10.h,
                  ),
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
