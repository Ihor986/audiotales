part of 'main_screen_bloc.dart';

abstract class MainScreenEvent {}

class ClickPlayEvent extends MainScreenEvent {
  ClickPlayEvent(this.path);
  String path;
}

class Rewind15Event extends MainScreenEvent {
  Rewind15Event(this.time);
  int time;
}
