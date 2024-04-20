part of 'player_bloc.dart';

@immutable
abstract class PlayerEvent extends Equatable {
  const PlayerEvent();

  @override
  List<Object?> get props => [];
}

class PlayPause extends PlayerEvent {
  final Audio audio;
  final String path;

  const PlayPause({required this.path, required this.audio});

  @override
  List<Object?> get props => [path];
}

class SeekPosition extends PlayerEvent {
  final Duration position;

  const SeekPosition({
    required this.position,
  });
}

class SkipNext extends PlayerEvent {
  final Audio audio;
  final String path;

  const SkipNext({required this.path, required this.audio});

  @override
  List<Object?> get props => [path];
}

class InitAudio extends PlayerEvent {
  final Audio? audio;

  const InitAudio({required this.audio});

  @override
  List<Object?> get props => [audio?.name];
}

class InitAudioOffline extends PlayerEvent {
  final LocalAudio audio;

  const InitAudioOffline({required this.audio});
}
