import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:melbook/features/home/data/service/file_service.dart';
import 'package:melbook/features/home/data/service/local_audio_service.dart';
import 'package:melbook/features/home/data/service/localbook_service.dart';
import 'package:meta/meta.dart';

import '../../../data/models/audio.dart';
import '../../../data/models/local_book.dart';

part 'local_storage_event.dart';
part 'local_storage_state.dart';

class LocalStorageBloc extends Bloc<LocalStorageEvent, LocalStorageState> {
  LocalStorageBloc() : super(const LocalStorageInitial(books: [])) {
    on<GetAllAudios>(_getAllAudios);
    on<DownloadAllAudios>(_downloadAllAudios);
  }

  Future<void> _getAllAudios(
      GetAllAudios event, Emitter<LocalStorageState> emit) async {
    final books = await SqfliteService().getBooks();
    final audioNames = books.first.audios.map((e) => e.name).toList();
    final audioNamesWithLesson = audioNames
        .where(
          (e) => e.contains(r"\"),
        )
        .toList();
    for (var element in audioNamesWithLesson) {
      final splitted = element.split(r"\");
      final lesson = splitted[0];
      final name = splitted[1];
      print("Name: $name Lesson: $lesson");
    }
    emit(GetAllAudiosState(books: books));
  }

  Future<void> _downloadAllAudios(
      DownloadAllAudios event, Emitter<LocalStorageState> emit) async {
    int results = 0;
    emit(DownloadWaiting(books: state.books));

    try {
      await Future.forEach(event.audios, (element) async {
        if (element.audioUrl.contains(".json")) {
          await LocalAudioService.saveAudio(
              element.name, "no audio", event.book, element.content);
          results++;
          emit(Progress(progress: results, books: state.books));
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
    ));

    final books = await SqfliteService().getBooks();
    emit(DownloadSuccess(books: books));
    // }
  }
}
