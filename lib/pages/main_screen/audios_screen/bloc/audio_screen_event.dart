part of 'audio_screen_bloc.dart';

@immutable
abstract class AudioScreenEvent {}

class AudioScreenPlayAllEvent extends AudioScreenEvent {
  AudioScreenPlayAllEvent({required this.talesList});
  final List<AudioTale> talesList;
}

class AudioScreenChangeRepeatEvent extends AudioScreenEvent {}

class AudioScreenContinueEvent extends AudioScreenEvent {
  AudioScreenContinueEvent({required this.talesList});
  final List<AudioTale> talesList;
}
