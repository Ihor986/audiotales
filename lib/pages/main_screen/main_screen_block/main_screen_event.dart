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

class DeleteAudioEvent extends MainScreenEvent {
  DeleteAudioEvent({required this.audio, required this.list});
  AudioTale audio;
  TalesList list;
}
