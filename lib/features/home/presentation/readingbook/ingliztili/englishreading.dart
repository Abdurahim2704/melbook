import 'dart:async';

import 'package:draggable_scrollbar/draggable_scrollbar.dart';
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
  Timer? _debounce;
  Duration debounceDuration = const Duration(milliseconds: 300);
  Future<void> init() async {
    if (controller.hasClients) {
      await getIt<SharedPreferenceService>()
          .saveLastReadBook(1, pixel);
    }
  }


  @override
  void initState() {
    super.initState();
    pixel = widget.initialPosition;
    controller = ScrollController(
      initialScrollOffset: widget.initialPosition,
    )..addListener(() {
        if (controller.hasClients &&
            viewport < controller.position.maxScrollExtent) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
            await Future.delayed(const Duration(seconds: 1));
            if (mounted) {
              viewport = controller.position.maxScrollExtent;
              setState(() {});
            }
          });
        }
        if (_debounce?.isActive ?? false) _debounce?.cancel();
        _debounce = Timer(debounceDuration, () {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            pixel = controller.position.pixels;
            pixelStream.add(pixel);
          });
          scrolling.add((controller.position.pixels -
                      widget.initialPosition )
                  .abs() >
              200);
        });
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
              child: DraggableScrollbar.rrect(
                backgroundColor: Colors.black45,
                alwaysVisibleScrollThumb: true,
                controller: controller,
                child: ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: controller,
                  cacheExtent: 1000,
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
          ),
          Align(
            alignment: const Alignment(0.8, 0.9),
            child: StreamBuilder<bool>(
                stream: scrolling.stream,
                builder: (context, snapshot) {
                  if (snapshot.data ?? false) {
                    return Container(
                      width: 70.0,
                      height: 70.0,
                      decoration: const BoxDecoration(
                        color: Colors.black12,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.bookmark,
                            size: 30, color: Colors.white),
                        onPressed: () {
                          controller.animateTo(
                            widget.initialPosition,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeIn,
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    init();
    controller.dispose();
    _debounce?.cancel();
    scrolling.close();
    pixelStream.close();
    super.dispose();
  }
}
