part of 'player_bloc.dart';

@immutable
abstract class PlayerState extends Equatable {
  final String? path;
  final bool isPlaying;

  const PlayerState({this.path, this.isPlaying = false});

  @override
  List<Object?> get props => [
        path,
        isPlaying,
      ];
}

class PlayerInitial extends PlayerState {
  const PlayerInitial({super.path, super.isPlaying = false});
}

class PlayerLoading extends PlayerState {
  const PlayerLoading({
    required super.path,
    super.isPlaying,
  });
}

class PlayerSuccessState extends PlayerState {
  const PlayerSuccessState({
    required super.path,
    super.isPlaying,
  });

  @override
  List<Object?> get props => [path, isPlaying];
}

class PlayerErrorState extends PlayerState {
  const PlayerErrorState({
    required super.path,
    super.isPlaying,
  });
}
