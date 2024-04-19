part of 'player_bloc.dart';

@immutable
abstract class PlayerState extends Equatable {
  final String? path;
  final bool isPlaying;
  final Audio? audio;

  const PlayerState({this.path, this.isPlaying = false, this.audio});

  @override
  List<Object?> get props => [path, isPlaying, audio];
}

class PlayerInitial extends PlayerState {
  const PlayerInitial({super.path, super.isPlaying = false, super.audio});
}

class PlayerLoading extends PlayerState {
  const PlayerLoading(
      {required super.path, super.isPlaying, required super.audio});
}

class PlayerSuccessState extends PlayerState {
  const PlayerSuccessState(
      {required super.path, super.isPlaying, required super.audio});

  @override
  List<Object?> get props => [path, audio?.name, isPlaying];
}

class PlayerErrorState extends PlayerState {
  const PlayerErrorState(
      {required super.path, super.isPlaying, required super.audio});
}
