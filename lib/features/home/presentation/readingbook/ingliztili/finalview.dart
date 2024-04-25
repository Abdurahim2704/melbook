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
  int maxLines = 11;
  List<Slice> slices = [];

  void makeCut(List<LocalAudio> audios) {
    List<LocalAudio> result = [];
    List<DialogPairs>? remained;
    int currentDialogs = 0;
    for (var audio in audios) {
      final dialogs = audio.description;
      if ((dialogs.length + currentDialogs) > maxLines) {
        final lastText = dialogs.take(maxLines - currentDialogs).toList();
        slices.add(Slice(
            audios: result,
            lastText: lastText,
            lastAudio: audio,
            remained: remained));
        remained = dialogs.skip(maxLines - currentDialogs).toList();
        result = [];
        currentDialogs = 0;
      } else if ((dialogs.length + currentDialogs) == maxLines) {
        result.add(audio);
        slices.add(Slice(audios: result, remained: remained));
        remained = null;
        result = [];
        currentDialogs = 0;
      } else {
        result.add(audio);
        currentDialogs += dialogs.length;
      }
    }
    if (result.isNotEmpty || remained != null) {
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
  final List<DialogPairs>? lastText;
  final LocalAudio? lastAudio;
  final List<DialogPairs>? remained;

  const Slice(
      {this.lastText, required this.audios, this.lastAudio, this.remained});
}
