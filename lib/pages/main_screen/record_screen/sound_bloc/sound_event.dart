part of 'sound_bloc.dart';

abstract class SoundEvent {}

class StartRecordEvent extends SoundEvent {}

class SaveRecordEvent extends SoundEvent {
  SaveRecordEvent({required this.talesListRep, required this.localUser});
  TalesList talesListRep;
  LocalUser localUser;
}

class StopRecordEvent extends SoundEvent {}

class StartPlaydEvent extends SoundEvent {}
