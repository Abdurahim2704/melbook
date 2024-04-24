part of 'local_storage_bloc.dart';

sealed class LocalStorageState {
  final List<LocalAudio> audios;

  const LocalStorageState(this.audios);
}

final class LocalStorageInitial extends LocalStorageState {
  LocalStorageInitial(super.audios);
}

class DownloadSuccess extends LocalStorageState {
  DownloadSuccess(super.audios);
}

class DownloadFailed extends LocalStorageState {
  final String message;

  const DownloadFailed(super.audios, {required this.message});
}

class DownloadWaiting extends LocalStorageState {
  DownloadWaiting(super.audios);
}

class GetAllAudiosSuccess extends LocalStorageState {
  const GetAllAudiosSuccess(super.audios);
}
