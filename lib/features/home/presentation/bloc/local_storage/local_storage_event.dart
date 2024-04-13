part of 'local_storage_bloc.dart';

@immutable
sealed class LocalStorageEvent {
  const LocalStorageEvent();
}

class DownloadFileAndSave extends LocalStorageEvent {
  final String link;
  final String name;
  final String book;

  const DownloadFileAndSave(
      {required this.link, required this.name, required this.book});
}

class GetAllAudios extends LocalStorageEvent {}
