import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:melbook/features/home/data/service/file_service.dart';
import 'package:melbook/features/home/data/service/local_audio_service.dart';
import 'package:meta/meta.dart';

import '../../../data/models/audio.dart';

part 'local_storage_event.dart';
part 'local_storage_state.dart';

class LocalStorageBloc extends Bloc<LocalStorageEvent, LocalStorageState> {
  LocalStorageBloc() : super(const LocalStorageInitial([])) {
    on<DownloadFileAndSave>(_downloadFileAndSave);
    on<GetAllAudios>(_getAllAudios);
    on<DownloadAllAudios>(_downloadAllAudios);
  }

  Future<void> _downloadFileAndSave(
      DownloadFileAndSave event, Emitter<LocalStorageState> emit) async {
    emit(DownloadWaiting(state.audios));
    try {
      final result = await LocalService()
          .downloadFile(event.name, event.link, event.book, event.description);
      final audios = await LocalAudioService.getAudios();
      if (result.toInt() == 1) {
        emit(DownloadSuccess(audios));
      }
    } catch (e) {
      DownloadFailed(state.audios, message: e.toString());
    }
  }

  Future<void> _getAllAudios(
      GetAllAudios event, Emitter<LocalStorageState> emit) async {
    print("I am here you dumpass");
    final service = await LocalAudioService.getAudios();
    final audios = service.where((element) {
      final file = File(element.location);
      return file.existsSync();
    }).toList();
    print(audios.length);
    emit(DownloadSuccess(audios));
  }

  Future<void> _downloadAllAudios(
      DownloadAllAudios event, Emitter<LocalStorageState> emit) async {
    int results = 0;
    emit(DownloadWaiting(state.audios));
    await Future.forEach(event.audios, (element) async {
      final result = await LocalService().downloadFile(
          element.name, element.audioUrl, event.book, element.content);
      if (result.toInt() == 1) {
        results++;
        emit(Progress(state.audios, progress: results));
      }
    });
    if (results == event.audios.length) {
      final audios = await LocalAudioService.getAudios();
      emit(DownloadSuccess(audios));
    }
  }
}
