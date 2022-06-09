part of 'delete_bloc.dart';

@immutable
abstract class DeleteEvent {}

class DeleteAudioEvent extends DeleteEvent {
  DeleteAudioEvent({required this.id, required this.talesList});
  final String id;
  final TalesList talesList;
}
