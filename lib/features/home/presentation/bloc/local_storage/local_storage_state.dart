part of 'local_storage_bloc.dart';

sealed class LocalStorageState extends Equatable {
  final List<LocalAudio> audios;
  final List<LocalBook> books;

  const LocalStorageState(this.audios, {required this.books});

  @override
  List<Object?> get props => [audios];
}

final class LocalStorageInitial extends LocalStorageState {
  const LocalStorageInitial(super.audios, {required super.books});
}

class DownloadSuccess extends LocalStorageState {
  const DownloadSuccess(super.audios, {required super.books});
}

class DownloadFailed extends LocalStorageState {
  final String message;

  const DownloadFailed(super.audios,
      {required this.message, required super.books});
}

class DownloadWaiting extends LocalStorageState {
  const DownloadWaiting(super.audios, {required super.books});
}

class Progress extends LocalStorageState {
  final int progress;

  const Progress(super.audios, {required this.progress, required super.books});

  @override
  List<Object?> get props => [progress];
}

class GetAllAudiosState extends LocalStorageState {
  const GetAllAudiosState(super.audios, {required super.books});
}
