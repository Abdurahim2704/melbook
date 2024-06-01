part of 'local_storage_bloc.dart';

@immutable
sealed class LocalStorageEvent {
  const LocalStorageEvent();
}

class GetAllAudios extends LocalStorageEvent {}

class DownloadAllAudios extends LocalStorageEvent {
  final List<Audio> audios;
  final String book;
  final String imageUrl;
  final String description;
  final String author;

  const DownloadAllAudios({
    required this.audios,
    required this.book,
    required this.imageUrl,
    required this.description,
    required this.author,
  });
}
