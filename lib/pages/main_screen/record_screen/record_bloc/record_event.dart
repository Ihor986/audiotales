part of 'record_bloc.dart';

abstract class RecordEvent {}

class StartRecordEvent extends RecordEvent {}

class SaveRecordEvent extends RecordEvent {
  SaveRecordEvent({
    required this.talesListRep,
    required this.localUser,
    required this.isAutosaveLocal,
  });
  TalesList talesListRep;
  LocalUser localUser;
  bool isAutosaveLocal;
}

class StartPlaydEvent extends RecordEvent {}

class SetStateEvent extends RecordEvent {}
