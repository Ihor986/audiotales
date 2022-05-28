part of 'audio_screen_bloc.dart';

class AudioScreenState {
  AudioScreenState(
      {required this.sound,
      this.isPlayAll = false,
      this.soundIndex = 0,
      this.isPlaying = false});
  // final DataBase db = DataBase.instance;
  final SoundService sound;
  int soundIndex;
  bool isPlayAll;
  bool isPlaying;
}
