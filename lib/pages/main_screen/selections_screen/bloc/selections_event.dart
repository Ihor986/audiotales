part of 'selections_bloc.dart';

abstract class SelectionsEvent {}

class CreateNewSelectonEvent extends SelectionsEvent {
  // CheckEvent({required this.checkedList});
  // List<String> checkedList;
}

class CheckEvent extends SelectionsEvent {
  CheckEvent({required this.isChecked, required this.id});
  bool isChecked;
  String id;
}

class SaveCreatedSelectionEvent extends SelectionsEvent {
  SaveCreatedSelectionEvent(
      {required this.talesList, required this.selectionsList});
  TalesList talesList;
  SelectionsList selectionsList;
}
// String id;

class ClearChekedEvent extends SelectionsEvent {}

class CreateSelectionNameEvent extends SelectionsEvent {
  CreateSelectionNameEvent({required this.value});
  String value;
}
