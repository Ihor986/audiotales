part of 'sound_bloc.dart';

abstract class SoundEvent {}

class StartRecordEvent extends SoundEvent {}

class SaveRecordEvent extends SoundEvent {
  SaveRecordEvent(this.talesListRep);
  TalesList talesListRep;
}

class StopRecordEvent extends SoundEvent {}

class StartPlaydEvent extends SoundEvent {}
