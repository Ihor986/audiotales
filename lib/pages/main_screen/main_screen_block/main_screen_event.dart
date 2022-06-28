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

class SetState extends MainScreenEvent {}

class DeleteUnsavedAudioEvent extends MainScreenEvent {}

class ChangeAudioNameEvent extends MainScreenEvent {
  ChangeAudioNameEvent({required this.audio});
  final AudioTale audio;
}

class ShareAudioEvent extends MainScreenEvent {
  ShareAudioEvent({required this.audio});
  final AudioTale audio;
}

class ShareAudiosEvent extends MainScreenEvent {
  ShareAudiosEvent({
    required this.audioList,
    this.name,
    this.idList,
  });
  final List<AudioTale> audioList;
  final String? name;
  final List<String>? idList;
}

class SaveChangedAudioNameEvent extends MainScreenEvent {
  SaveChangedAudioNameEvent({
    required this.audio,
    required this.fullTalesList,
  });
  final AudioTale audio;
  final TalesList fullTalesList;
}

class EditingAudioNameEvent extends MainScreenEvent {
  EditingAudioNameEvent({required this.value});
  final String value;
}

// class DeleteAudioEvent extends MainScreenEvent {
//   DeleteAudioEvent({required this.id, required this.talesList});
//   final String id;
//   final TalesList talesList;
// }
