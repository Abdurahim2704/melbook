import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:melbook/features/audio/data/audio_service.dart';
import 'package:melbook/features/home/data/service/local_audio_service.dart';
import 'package:meta/meta.dart';

import '../../../../home/data/models/audio.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc() : super(const PlayerInitial()) {
    on<PlayPause>(_playPause);
    on<SeekPosition>(_seekPosition);
    on<SkipNext>(_skipNext);
    on<InitAudio>(_initAudio);
  }

  Future<void> _playPause(PlayPause event, Emitter<PlayerState> emit) async {
    emit(PlayerLoading(
        path: state.path, isPlaying: state.isPlaying, audio: state.audio));
    if ((event.path == state.path) && state.isPlaying) {
      AudioServiceImpl.pause();
      emit(PlayerSuccessState(
          isPlaying: false, path: event.path, audio: event.audio));
    } else if (event.path == state.path) {
      AudioServiceImpl.play();
      emit(PlayerSuccessState(
          path: event.path, isPlaying: true, audio: event.audio));
    } else {
      AudioServiceImpl.playNewTrack(event.path);
      AudioServiceImpl.play();
      emit(PlayerSuccessState(
          path: event.path, isPlaying: true, audio: event.audio));
    }
  }

  Future<void> _seekPosition(
      SeekPosition event, Emitter<PlayerState> emit) async {
    await AudioServiceImpl.seekDuration(event.position);
  }

  Future<void> _skipNext(SkipNext event, Emitter<PlayerState> emit) async {
    AudioServiceImpl.playNewTrack(event.path);
    AudioServiceImpl.play();
    emit(PlayerSuccessState(
        isPlaying: true, path: event.path, audio: event.audio));
  }

  Future<void> _initAudio(InitAudio event, Emitter<PlayerState> emit) async {
    emit(PlayerSuccessState(path: state.path, audio: event.audio));
  }
}
