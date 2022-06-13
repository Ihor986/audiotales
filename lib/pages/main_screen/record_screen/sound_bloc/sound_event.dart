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
