import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melbook/features/home/data/service/last_read.dart';
import 'package:melbook/features/home/data/service/local_audio_service.dart';
import 'package:melbook/features/home/presentation/readingbook/ingliztili/englishreading.dart';
import 'package:page_flip/page_flip.dart';

import '../../../../../locator.dart';
import '../../bloc/local_storage/local_storage_bloc.dart';

class FinalView extends StatefulWidget {
  const FinalView({super.key});

  @override
  State<FinalView> createState() => _FinalViewState();
}

class _FinalViewState extends State<FinalView> {
  final _controller = GlobalKey<PageFlipWidgetState>();
  int maxPoints = 23;
  List<Slice> slices = [];

  // void makeCut(List<LocalAudio> audios) {
  //   List<LocalAudio> result = [];
  //   List<DialogPairs>? remained;
  //   int currentDialogs = 0;
  //   int currentPoints = 0;
  //   for (var audio in audios) {
  //     final dialogs = audio.description;
  //     final myPoints = (currentPoints +
  //         dialogs
  //             .map((e) => e.points)
  //             .reduce((value, element) => element + value));
  //     if (myPoints > maxLines) {
  //       final lastText = dialogs.take(maxLines - currentDialogs).toList();
  //       slices.add(Slice(
  //         audios: result,
  //         lastText: lastText,
  //         lastAudio: audio,
  //         remained: remained,
  //       ));
  //       remained = dialogs.skip(maxLines - currentDialogs).toList();
  //       result = [];
  //       currentDialogs = 0;
  //       currentPoints = 0;
  //     } else if (currentPoints == maxLines) {
  //       result.add(audio);
  //       slices.add(Slice(audios: result, remained: remained));
  //       remained = null;
  //       result = [];
  //       currentDialogs = 0;
  //       currentPoints = 0;
  //     } else {
  //       result.add(audio);
  //       currentDialogs += dialogs.length;
  //       currentPoints += dialogs
  //           .map((e) => e.points)
  //           .reduce((value, element) => value + element);
  //     }
  //   }
  //   if (result.isNotEmpty || remained != null) {
  //     slices.add(Slice(audios: result, remained: remained));
  //   }
  // }

  void makeCut(List<LocalAudio> audios) {
    List<LocalAudio> result = [];
    List<DialogPairs>? remained;
    int currentPoints = 0;
    LocalAudio? currentOne;
    try {
      for (var audio in audios) {
        currentOne = audio;
        // calculate points
        final dialogs = audio.description; // audios dialogs
        final audiosPoints = audio.pointCount(); // current audios points

        if (audio.name.contains("4.3") || audio.name.contains("4.4")) {
          print("I am here");
        }
        final remainedPoints = (remained ?? []).map((e) => e.points).fold<int>(
              0,
              (value, element) => value + element,
            ); // remained points from previous

        final totalPoints =
            currentPoints + audiosPoints + remainedPoints; // sum of all points

        if (audio.pointCount() >= maxPoints) {
          final partSlices = getAmountSlices(dialogs, maxPoints, audio);
          slices.addAll(partSlices);
          continue;
        }
        if (totalPoints > maxPoints) {
          final lastText = getLastDialogs(dialogs, maxPoints, currentPoints);
          slices.add(Slice(
            audios: result,
            lastText: lastText,
            lastAudio: audio,
            remained: remained,
          ));

          remained = dialogs.sublist(lastText.length);
          result = [];
          currentPoints = 0;
        } else if (totalPoints == maxPoints) {
          result.add(audio);
          slices.add(Slice(audios: result, remained: remained));

          // reset values
          remained = null;
          result = [];
          currentPoints = 0;
        } else {
          result.add(audio);
          currentPoints +=
              totalPoints; // Update currentPoints with the total points
        }
      }
      if (result.isNotEmpty || remained != null) {
        slices.add(Slice(audios: result, remained: remained));
      }
    } catch (e) {
      print(currentOne?.description.length);
      print(currentOne?.location);
      print(currentOne?.name);
    }
  }

  List<DialogPairs> getLastDialogs(
      List<DialogPairs> dialogs, int maxLines, int currentPoints) {
    /// getting audios which fits in page

    List<DialogPairs> list = [];
    for (int i = 0; i < dialogs.length; i++) {
      final listPoints = list
          .map((e) => e.points)
          .fold<int>(0, (value, element) => value + element);
      if (dialogs[i].points + listPoints <= (maxLines - currentPoints)) {
        list.add(dialogs[i]);
      } else {
        return list;
      }
    }
    return list;
  }

  List<Slice> getAmountSlices(
      List<DialogPairs> dialogs, int points, LocalAudio audio) {
    /// getting audios which fits in page
    List<Slice> slices = [];
    List<DialogPairs> list = [];
    for (int i = 0; i < dialogs.length; i++) {
      final listPoints = list
          .map((e) => e.points)
          .fold<int>(0, (value, element) => value + element);
      if (dialogs[i].points + listPoints <= points) {
        list.add(dialogs[i]);
      } else {
        slices.add(Slice(audios: [], lastText: list));
        list = [];
      }
    }
    if (slices.isNotEmpty) {
      slices.first.lastAudio = audio;
    }
    return slices;
  }

  @override
  Widget build(BuildContext context) {
    getIt<SharedPreferenceService>()
        .getLastPage()
        .then((value) => print("Last index:$value"));
    return Scaffold(
      body: BlocBuilder<LocalStorageBloc, LocalStorageState>(
        builder: (context, state) {
          print("I am here2");
          makeCut(state.audios);
          print("I am here3 ");
          print("Slices: ${slices.length}");
          return FutureBuilder<int>(
              future: getIt<SharedPreferenceService>().getLastPage(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  print("I am here");
                  print("Slices: ${slices.length}");
                  return PageFlipWidget(
                    key: _controller,
                    initialIndex: (snapshot.data ?? -1) + 1,
                    lastPage: Container(
                      color: Colors.white,
                      child: const Center(
                        child: Text(
                          "E'tiboringiz uchun rahmat!",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    children: <Widget>[
                      for (var i = 0; i < slices.length; i++)
                        IngliztiliReading(
                          slice: slices[i],
                          lastText: slices[i].lastText,
                          index: i,
                        ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              });

          //     PageView(
          //   physics: PageScrollPhysics(),
          //   children: <Widget>[
          //     for (var i = 0; i < slices.length; i++)
          //       IngliztiliReading(
          //         slice: slices[i],
          //         lastText: slices[i].lastText,
          //         index: i,
          //       ),
          //   ],
          // );
        },
      ),
    );
  }
}

class Slice {
  final List<LocalAudio> audios;
  final List<DialogPairs>? lastText;
  LocalAudio? lastAudio;
  final List<DialogPairs>? remained;

  Slice({
    this.lastText,
    required this.audios,
    this.lastAudio,
    this.remained,
  });
}
