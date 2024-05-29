import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:melbook/features/home/data/service/file_service.dart';
import 'package:melbook/features/home/data/service/local_audio_service.dart';
import 'package:melbook/features/home/data/service/localbook_service.dart';
import 'package:meta/meta.dart';

import '../../../data/models/audio.dart';
import '../../../data/models/local_book.dart';
import '../../../data/models/slice.dart';

part 'local_storage_event.dart';
part 'local_storage_state.dart';

class LocalStorageBloc extends Bloc<LocalStorageEvent, LocalStorageState> {
  LocalStorageBloc() : super(const LocalStorageInitial(books: [])) {
    on<DownloadFileAndSave>(_downloadFileAndSave);
    on<GetAllAudios>(_getAllAudios);
    on<DownloadAllAudios>(_downloadAllAudios);
  }

  Future<void> _downloadFileAndSave(
      DownloadFileAndSave event, Emitter<LocalStorageState> emit) async {
    emit(DownloadWaiting(books: state.books));
    try {
      final result = await LocalService().downloadFile(
          event.name, event.link, event.book, event.description, ".mp3");
      final audios = await LocalAudioService.getAudios();
      if (result.toInt() == 1) {
        emit(DownloadSuccess(books: state.books));
      }
    } catch (e) {
      DownloadFailed(message: e.toString(), books: state.books);
    }
  }

  Future<void> _getAllAudios(
      GetAllAudios event, Emitter<LocalStorageState> emit) async {
    final books = await SqfliteService().getBooks();
    print(books.length);
    emit(GetAllAudiosState(books: books));
  }

  Future<void> _downloadAllAudios(
      DownloadAllAudios event, Emitter<LocalStorageState> emit) async {
    int results = 0;
    emit(DownloadWaiting(books: state.books));

    try {
      await Future.forEach(event.audios, (element) async {
        print("Name: ${element.name} Location: ${element.audioUrl}");

        if (element.audioUrl.contains(".json")) {
          await LocalAudioService.saveAudio(
              element.name, "no audio", event.book, element.content);
          results++;
        } else {
          final result = await LocalService().downloadFile(element.name,
              element.audioUrl, event.book, element.content, ".mp3");
          if (result.toInt() == 1) {
            results++;
            emit(Progress(progress: results, books: state.books));
          }
        }
      });
    } catch (e) {
      emit(DownloadFailed(
          message: "Error when downloading files", books: state.books));
    }
    // if (results == event.audios.length) {
    final audios = await LocalAudioService.getAudios();
    print("Audio: ${audios.length}");
    await SqfliteService().insertBook(LocalBook(
        name: event.book,
        audios: audios,
        description: event.description,
        author: event.author,
        slices: makeCut(audios)));

    final books = await SqfliteService().getBooks();
    emit(DownloadSuccess(books: books));
    // }
  }

  int maxPoints = 23;

  List<Slice> makeCut(List<LocalAudio> audios) {
    final slices = <Slice>[];
    List<LocalAudio> result = [];
    List<DialogPairs>? remained;
    int currentPoints = 0;
    LocalAudio? currentOne;
    try {
      for (var audio in audios) {
        currentOne = audio;

        if (audio.name.contains("3.4") ||
            audio.name.contains("4.5") ||
            audio.name.contains("9.3")) {
          print("hello");
        }
        final dialogs = audio.description; // audios dialogs
        final diloagPoint = audio.description
            .map((e) => e.points)
            .reduce((value, element) => value + element);
        if (diloagPoint >= maxPoints) {
          final (partSlices, remainDialogs) =
              getAmountSlices(dialogs, maxPoints, audio, remained ?? []);
          partSlices[0].remained = remained;
          remained = [...remainDialogs];
          slices.addAll(partSlices);
          continue;
        }

        final audiosPoints = audio.pointCount(); // current audios points
        final remainedPoints = (remained ?? []).map((e) => e.points).fold<int>(
              0,
              (value, element) => value + element,
            ); // remained points from previous

        final totalPoints =
            currentPoints + audiosPoints + remainedPoints; // sum of all points
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
    return slices;
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

  (List<Slice>, List<DialogPairs>) getAmountSlices(List<DialogPairs> dialogs,
      int points, LocalAudio audio, List<DialogPairs> remained) {
    /// getting audios which fits in page
    List<Slice> slices = [];
    if (audio.name.contains("3.4")) {
      print("object");
    }
    List<DialogPairs> list = [];
    for (int i = 0; i < dialogs.length; i++) {
      final listPoints = list
          .map((e) => e.points)
          .fold<int>(0, (value, element) => value + element);
      if (slices.isEmpty) {
        if (dialogs[i].points +
                listPoints +
                remained
                    .map((e) => e.points)
                    .fold<int>(0, (value, element) => value + element) <=
            points) {
          list.add(dialogs[i]);
        } else {
          slices.add(Slice(audios: [], lastText: list));
          list = [];
        }
      } else if (dialogs[i].points + listPoints <= points) {
        list.add(dialogs[i]);
      } else {
        slices.add(Slice(audios: [], lastText: list));
        list = [];
      }
    }
    if (slices.isNotEmpty) {
      slices.first.lastAudio = audio;
    }
    return (slices, list);
  }
}
