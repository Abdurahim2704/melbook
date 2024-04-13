part of 'local_storage_bloc.dart';

sealed class LocalStorageState {
  const LocalStorageState();
}

final class LocalStorageInitial extends LocalStorageState {}

class DownloadSuccess extends LocalStorageState {}

class DownloadFailed extends LocalStorageState {
  final String message;

  const DownloadFailed({required this.message});
}

class DownloadWaiting extends LocalStorageState {}

class GetAllAudiosSuccess extends LocalStorageState {
  final List<Map<String, dynamic>> audios;

  const GetAllAudiosSuccess({
    required this.audios,
  });
}
