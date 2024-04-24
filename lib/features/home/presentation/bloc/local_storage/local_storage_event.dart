part of 'local_storage_bloc.dart';

@immutable
sealed class LocalStorageEvent {
  const LocalStorageEvent();
}

class DownloadFileAndSave extends LocalStorageEvent {
  final String link;
  final String name;
  final String book;
  final String description;

  const DownloadFileAndSave(
      {required this.link,
      required this.name,
      required this.book,
      required this.description});
}

class GetAllAudios extends LocalStorageEvent {}

class DownloadAllAudios extends LocalStorageEvent {
  final List<Audio> audios;

  const DownloadAllAudios({required this.audios});
}
