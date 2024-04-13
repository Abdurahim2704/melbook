import 'package:bloc/bloc.dart';
import 'package:melbook/features/home/data/service/file_service.dart';
import 'package:melbook/features/home/data/service/local_audio_service.dart';
import 'package:meta/meta.dart';

part 'local_storage_event.dart';
part 'local_storage_state.dart';

class LocalStorageBloc extends Bloc<LocalStorageEvent, LocalStorageState> {
  LocalStorageBloc() : super(LocalStorageInitial()) {
    on<DownloadFileAndSave>(_downloadFileAndSave);
    on<GetAllAudios>(_getAllAudios);
  }

  Future<void> _downloadFileAndSave(
      DownloadFileAndSave event, Emitter<LocalStorageState> emit) async {
    emit(DownloadWaiting());
    try {
      final result =
          await LocalService().downloadFile(event.name, event.link, event.book);
      final path = await LocalService().getFilePath(event.name, event.book);
      await LocalAudioService.saveAudio(event.name, path, event.book);
      if (result.toInt() == 1) {
        emit(DownloadSuccess());
      }
    } catch (e) {
      DownloadFailed(message: e.toString());
    }
  }

  Future<void> _getAllAudios(
      GetAllAudios event, Emitter<LocalStorageState> emit) async {
    final service = await LocalAudioService.getAudios();
    emit(GetAllAudiosSuccess(audios: service));
  }
}
