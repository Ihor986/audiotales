part of 'delete_bloc.dart';

@immutable
abstract class DeleteEvent {}

class DeleteAudioEvent extends DeleteEvent {
  DeleteAudioEvent({
    required this.id,
    required this.talesList,
  });
  final String id;
  final TalesList talesList;
}

class SelectDeletedAudioEvent extends DeleteEvent {}

class CheckEvent extends DeleteEvent {
  CheckEvent({
    required this.isChecked,
    required this.id,
  });
  final bool isChecked;
  final String id;
}

class DeleteSelectedAudioEvent extends DeleteEvent {
  DeleteSelectedAudioEvent({
    required this.talesList,
  });
  final TalesList talesList;
}

class RestoreSelectedAudioEvent extends DeleteEvent {
  RestoreSelectedAudioEvent({
    required this.talesList,
  });
  final TalesList talesList;
}

// class DeleteOldAudioEvent extends DeleteEvent {
//   DeleteOldAudioEvent({
//     required this.talesList,
//   });
//   final TalesList talesList;
// }
