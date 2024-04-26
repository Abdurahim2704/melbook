part of 'local_storage_bloc.dart';

sealed class LocalStorageState extends Equatable {
  final List<LocalAudio> audios;

  const LocalStorageState(this.audios);

  @override
  List<Object?> get props => [audios];
}

final class LocalStorageInitial extends LocalStorageState {
  const LocalStorageInitial(super.audios);
}

class DownloadSuccess extends LocalStorageState {
  const DownloadSuccess(super.audios);
}

class DownloadFailed extends LocalStorageState {
  final String message;

  const DownloadFailed(super.audios, {required this.message});
}

class DownloadWaiting extends LocalStorageState {
  const DownloadWaiting(super.audios);
}

class Progress extends LocalStorageState {
  final int progress;

  const Progress(super.audios, {required this.progress});
}
