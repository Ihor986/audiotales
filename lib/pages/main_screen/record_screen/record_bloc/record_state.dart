part of 'record_bloc.dart';

class RecordState {
  RecordState({
    this.isProgress = false,
    this.readOnly = true,
    this.chahgedAudioId,
  });
  final bool isProgress;
  final bool readOnly;
  final String? chahgedAudioId;
}
