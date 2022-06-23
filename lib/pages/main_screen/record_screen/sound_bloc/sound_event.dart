part of 'sound_bloc.dart';

abstract class SoundEvent {}

class StartRecordEvent extends SoundEvent {}

class SaveRecordEvent extends SoundEvent {
  SaveRecordEvent({
    required this.talesListRep,
    required this.localUser,
    required this.isAutosaveLocal,
  });
  TalesList talesListRep;
  LocalUser localUser;
  bool isAutosaveLocal;
  // BuildContext context;
}

class StopRecordEvent extends SoundEvent {}

class StartPlaydEvent extends SoundEvent {}

class SetStateEvent extends SoundEvent {}

class ChangeAudioNameEvent extends SoundEvent {
  ChangeAudioNameEvent({required this.name});
  final String name;
}

class SaveChangedAudioNameEvent extends SoundEvent {
  SaveChangedAudioNameEvent({
    required this.audio,
    required this.fullTalesList,
  });
  final AudioTale audio;
  final TalesList fullTalesList;
}

class EditingAudioNameEvent extends SoundEvent {
  EditingAudioNameEvent({required this.value});
  final String value;
}
