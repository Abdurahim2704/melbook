import 'package:just_audio/just_audio.dart';
import 'package:melbook/features/home/data/models/audio.dart';

class AudioServiceImpl {
  final player = AudioPlayer();
  int current = 0;
  List<Audio> audios = [];
  Future<void> playNewTrack(String path) async {
    await player.setUrl(path);
    await player.play();
  }

  Future<void> init() async {}

  Future<bool> get isPlaying async => player.playing;

  Future<void> pause() async {
    await player.pause();
  }

  Future<void> play() async {
    await player.play();
  }

  Stream<Duration> audioDuration() {
    return player.positionStream;
  }

  Future<void> seekDuration(Duration position) async {
    await player.seek(position);
  }

  // Future<void> skipNext() async {
  //   await playNewTrack(tracks[(current + 1)]);
  // }

  void setAudio(List<Audio> myTrack) {
    audios.addAll(myTrack);
  }

  Future<void> skipPrevious() async {
    await player.seekToPrevious();
  }

  // Track get currentTrack => tracks[current];
}
