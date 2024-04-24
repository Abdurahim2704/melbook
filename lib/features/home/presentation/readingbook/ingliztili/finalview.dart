import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melbook/features/home/data/service/local_audio_service.dart';
import 'package:melbook/features/home/presentation/readingbook/ingliztili/englishreading.dart';
import 'package:page_flip/page_flip.dart';

import '../../bloc/local_storage/local_storage_bloc.dart';

class FinalView extends StatefulWidget {
  const FinalView({super.key});

  @override
  State<FinalView> createState() => _FinalViewState();
}

class _FinalViewState extends State<FinalView> {
  final _controller = GlobalKey<PageFlipWidgetState>();

  int maxLines = 1400;

  int symbolCount(String text) => text
      .split("\n")
      .map((e) => e.length)
      .reduce((value, element) => value + element);
  List<Slice> slices = [];

  void makeCut(List<LocalAudio> audios) {
    List<LocalAudio> result = [];
    String? remained;
    int currentLines = 0;
    for (var audio in audios) {
      final lines = symbolCount(audio.description);
      if ((lines + currentLines) > maxLines) {
        final lastText =
            audio.description.substring(0, maxLines - currentLines);
        slices.add(Slice(
            audios: result,
            lastText: lastText,
            lastAudio: audio,
            remained: remained));
        remained = audio.description.substring(maxLines - currentLines);
        result = [];
        currentLines = 0;
      } else if ((lines + currentLines) == maxLines) {
        result.add(audio);
        slices.add(Slice(audios: result, remained: remained));
        remained = null;
        result = [];
        currentLines = lines;
      } else {
        result.add(audio);
        currentLines += symbolCount(audio.description) + 20;
      }
    }
    if (result.isNotEmpty) {
      slices.add(Slice(audios: result, remained: remained));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocalStorageBloc, LocalStorageState>(
        builder: (context, state) {
          makeCut(state.audios);
          print(slices.length);
          return PageFlipWidget(
            key: _controller,
            backgroundColor: const Color.fromARGB(255, 139, 111, 111),
            initialIndex: 0,
            lastPage: Container(
                color: Colors.white,
                child: const Center(child: Text("E'tiboringiz uchun rahmat!"))),
            children: <Widget>[
              for (var i = 0; i < slices.length; i++)
                IngliztiliReading(
                  slice: slices[i],
                  lastText: slices[i].lastText,
                ),
            ],
          );
        },
      ),
    );
  }
}

class Slice {
  final List<LocalAudio> audios;
  final String? lastText;
  final LocalAudio? lastAudio;
  final String? remained;

  const Slice(
      {this.lastText, required this.audios, this.lastAudio, this.remained});
}
