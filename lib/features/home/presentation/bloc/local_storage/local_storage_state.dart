part of 'local_storage_bloc.dart';

sealed class LocalStorageState {
  final List<LocalAudio> audios;
  final String? downloadingAudio;

  const LocalStorageState(this.audios, {this.downloadingAudio});
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
  DownloadWaiting(super.audios, {required super.downloadingAudio});
}

class GetAllAudiosSuccess extends LocalStorageState {
  const GetAllAudiosSuccess(super.audios);
}
