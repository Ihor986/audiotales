part of 'sound_bloc.dart';

abstract class SoundEvent {}

class StartRecordEvent extends SoundEvent {}

class SaveRecordEvent extends SoundEvent {}

class StopRecordEvent extends SoundEvent {}
