import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:melbook/features/home/data/service/file_service.dart';
import 'package:melbook/features/home/data/service/local_audio_service.dart';
import 'package:meta/meta.dart';

import '../../../data/models/audio.dart';
import '../../../data/models/local_book.dart';

part 'local_storage_event.dart';
part 'local_storage_state.dart';

class LocalStorageBloc extends Bloc<LocalStorageEvent, LocalStorageState> {
  LocalStorageBloc() : super(const LocalStorageInitial([], books: [])) {
    on<DownloadFileAndSave>(_downloadFileAndSave);
    on<GetAllAudios>(_getAllAudios);
    on<DownloadAllAudios>(_downloadAllAudios);
  }

  Future<void> _downloadFileAndSave(
      DownloadFileAndSave event, Emitter<LocalStorageState> emit) async {
    emit(DownloadWaiting(state.audios, books: state.books));
    try {
      final result = await LocalService().downloadFile(
          event.name, event.link, event.book, event.description, ".mp3");
      final audios = await LocalAudioService.getAudios();
      if (result.toInt() == 1) {
        emit(DownloadSuccess(audios, books: state.books));
      }
    } catch (e) {
      DownloadFailed(state.audios, message: e.toString(), books: state.books);
    }
  }

  Future<void> _getAllAudios(
      GetAllAudios event, Emitter<LocalStorageState> emit) async {
    final service = await LocalAudioService.getAudios();
    final audios = service.where((element) {
      if (element.location == "no audio") {
        return true;
      }
      final file = File(element.location);
      return file.existsSync();
    }).toList();
    final books = await SqfliteService().getBooks();
    emit(GetAllAudiosState(audios, books: books));
  }

  Future<void> _downloadAllAudios(
      DownloadAllAudios event, Emitter<LocalStorageState> emit) async {
    int results = 0;
    emit(DownloadWaiting(state.audios, books: state.books));
    await Future.forEach(event.audios.take(10), (element) async {
      if (element.audioUrl.contains(".json")) {
        await LocalAudioService.saveAudio(
            element.name, "no audio", event.book, element.content);
        results++;
      } else {
        final result = await LocalService().downloadFile(element.name,
            element.audioUrl, event.book, element.content, ".mp3");
        if (result.toInt() == 1) {
          results++;
          print("Results: $results");
          emit(Progress(state.audios, progress: results, books: state.books));
        }
      }
    });
    // if (results == event.audios.length) {
    final audios = await LocalAudioService.getAudios();
    await SqfliteService().insertBook(LocalBook(
        name: event.book,
        audios: audios,
        description: event.description,
        author: event.author));

    final books = await SqfliteService().getBooks();
    emit(DownloadSuccess(audios, books: books));
    // }
  }
}
