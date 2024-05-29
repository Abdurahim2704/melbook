part of 'local_storage_bloc.dart';

sealed class LocalStorageState extends Equatable {
  final List<LocalBook> books;

  const LocalStorageState({required this.books});

  @override
  List<Object?> get props => [books.length];
}

final class LocalStorageInitial extends LocalStorageState {
  const LocalStorageInitial({required super.books});
}

class DownloadSuccess extends LocalStorageState {
  const DownloadSuccess({required super.books});
}

class DownloadFailed extends LocalStorageState {
  final String message;

  const DownloadFailed({required this.message, required super.books});
}

class DownloadWaiting extends LocalStorageState {
  const DownloadWaiting({required super.books});
}

class Progress extends LocalStorageState {
  final int progress;

  const Progress({required this.progress, required super.books});

  @override
  List<Object?> get props => [progress];
}

class GetAllAudiosState extends LocalStorageState {
  const GetAllAudiosState({required super.books});
}
