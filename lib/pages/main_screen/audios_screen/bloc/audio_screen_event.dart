part of 'audio_screen_bloc.dart';

@immutable
abstract class AudioScreenEvent {}

class AudioScreenPlayAllEvent extends AudioScreenEvent {
  AudioScreenPlayAllEvent({
    required this.talesList,
    required this.selection,
  });
  final List<AudioTale> talesList;
  final String? selection;
}

class AudioScreenChangeRepeatEvent extends AudioScreenEvent {}

class AudioScreenContinueEvent extends AudioScreenEvent {
  AudioScreenContinueEvent({required this.talesList});
  final List<AudioTale> talesList;
}

// class DeleteAudioEvent extends AudioScreenEvent {
//   DeleteAudioEvent({required this.id, required this.talesList});
//   final String id;
//   final TalesList talesList;
// }
