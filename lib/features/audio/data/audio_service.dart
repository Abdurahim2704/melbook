import 'package:just_audio/just_audio.dart';
import 'package:melbook/features/home/data/models/audio.dart';

class AudioServiceImpl {
  static final player = AudioPlayer()..setLoopMode(LoopMode.one);
  static int current = 0;
  static List<Audio> audios = [];

  static Future<void> playNewTrack(
    String path,
  ) async {
    await player.setFilePath(path, preload: false);
  }

  static Future<bool> get isPlaying async => player.playing;

  static Future<void> pause() async {
    await player.pause();
    // await player.seekToNext()
  }

  static Future<void> play() async {
    await player.play();
  }

  static Stream<Duration> audioDuration() {
    return player.positionStream;
  }

  static Future<void> seekDuration(Duration position) async {
    await player.seek(position);
  }

  static void setAudio(List<Audio> myTrack) {
    audios.addAll(myTrack);
  }

  static Future<void> skipPrevious() async {
    await player.seekToPrevious();
  }

  static Duration totalDuration() {
    return player.duration ?? const Duration(seconds: 0);
  }

  static Future<void> pauseAudio() {
    return player.pause();
  }
}
