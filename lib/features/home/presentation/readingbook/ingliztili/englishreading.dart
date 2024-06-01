import 'dart:async';

import 'package:flutter/material.dart';
import 'package:melbook/features/home/data/service/local_audio_service.dart';
import 'package:melbook/features/home/presentation/readingbook/ingliztili/lesson_widget.dart';

import '../../../../../locator.dart';
import '../../../data/service/last_read.dart';

class IngliztiliReading extends StatefulWidget {
  final double initialPosition;
  final List<LocalAudio> audios;

  const IngliztiliReading(
      {super.key, required this.audios, required this.initialPosition});

  @override
  State<IngliztiliReading> createState() => _IngliztiliReadingState();
}

class _IngliztiliReadingState extends State<IngliztiliReading> {
  final double horPadding = 30;
  final StreamController<bool> scrolling = StreamController<bool>();
  final StreamController<double> pixelStream = StreamController<double>();

  late final ScrollController controller;
  double pixel = 0.0;
  double viewport = 0.0;
  Future<void> init() async {
    await getIt<SharedPreferenceService>().saveLastReadBook(1, pixel);
  }

  @override
  void initState() {
    // print(widget.index);
    super.initState();
    pixel = widget.initialPosition;
    controller = ScrollController(
      initialScrollOffset: widget.initialPosition,
    )..addListener(() {
        if (controller.hasClients && viewport == 0.0) {
          viewport = controller.position.maxScrollExtent;
          setState(() {});
        }
        pixel = controller.position.pixels;
        pixelStream.add(pixel);
        scrolling.add(
            (controller.position.pixels - widget.initialPosition).abs() > 200);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horPadding),
                child: ListView.separated(
                  controller: controller,
                  itemBuilder: (context, index) {
                    final audio = widget.audios[index];
                    return LessonWidget(audio: audio);
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 5),
                  itemCount: widget.audios.length,
                ),
              ),
            ),
            if (viewport != 0.0)
              StreamBuilder(
                stream: pixelStream.stream,
                builder: (context, snapshot) {
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: SizedBox(
                        height: 40,
                        child: Slider(
                          min: 0,
                          max: viewport,
                          value: snapshot.data ?? 0,
                          onChanged: (value) {
                            pixel = value;
                            controller.jumpTo(value);
                          },
                        ),
                      ),
                    ),
                  );
                },
              )
          ],
        ),
        floatingActionButton: StreamBuilder<bool>(
            stream: scrolling.stream,
            builder: (context, snapshot) {
              if (snapshot.data ?? false) {
                return FloatingActionButton(
                  onPressed: () {
                    controller.animateTo(
                      widget.initialPosition,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeIn,
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            }));
  }

  // @override
  // void dispose() {
  //   init();
  //   controller.dispose();
  //   super.dispose();
  // }

  @override
  void dispose() {
    init();
    super.dispose();
  }
}
