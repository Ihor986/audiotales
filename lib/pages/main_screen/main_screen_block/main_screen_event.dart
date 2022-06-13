part of 'main_screen_bloc.dart';

abstract class MainScreenEvent {}

class ClickPlayEvent extends MainScreenEvent {
  ClickPlayEvent(this.audio);
  AudioTale audio;
}

class Rewind15Event extends MainScreenEvent {
  Rewind15Event(this.time);
  int time;
}

class RemoveToDeleteAudioEvent extends MainScreenEvent {
  RemoveToDeleteAudioEvent({required this.id, required this.talesList});
  final String id;
  final TalesList talesList;
}

class SearchAudioEvent extends MainScreenEvent {
  SearchAudioEvent({required this.value});
  String value;
}

class DeleteUnsavedAudioEvent extends MainScreenEvent {}

// class DeleteAudioEvent extends MainScreenEvent {
//   DeleteAudioEvent({required this.id, required this.talesList});
//   final String id;
//   final TalesList talesList;
// }
