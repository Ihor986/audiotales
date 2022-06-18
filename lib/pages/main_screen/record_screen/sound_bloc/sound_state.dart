part of 'sound_bloc.dart';

// @immutable
// abstract class SoundState {}

class SoundInitial {
  SoundInitial({this.isProgress = false, this.readOnly = true});
  final bool isProgress;
  final bool readOnly;
}
