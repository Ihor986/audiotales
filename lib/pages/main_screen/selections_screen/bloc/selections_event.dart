part of 'selections_bloc.dart';

abstract class SelectionsEvent {}

class CreateNewSelectonEvent extends SelectionsEvent {
  // CheckEvent({required this.checkedList});
  // List<String> checkedList;
}

class EditAllSelection extends SelectionsEvent {
  EditAllSelection({required this.selection});
  final Selection selection;
}

class CheckEvent extends SelectionsEvent {
  CheckEvent({required this.isChecked, required this.id});
  bool isChecked;
  String id;
}
// String id;

class ClearChekedEvent extends SelectionsEvent {}

// class RemoveFromSelectionChekedEvent extends SelectionsEvent {}

class UncheckAll extends SelectionsEvent {}

class ChangeSelectionNameEvent extends SelectionsEvent {
  ChangeSelectionNameEvent({required this.value});
  String value;
}

class EditSelectionNameEvent extends SelectionsEvent {
  EditSelectionNameEvent({required this.value});
  String value;
}

class ChangeSelectionDescriptionEvent extends SelectionsEvent {
  ChangeSelectionDescriptionEvent({required this.value});
  String value;
}

class SaveCreatedSelectionEvent extends SelectionsEvent {
  SaveCreatedSelectionEvent(
      {required this.talesList, required this.selectionsList});
  TalesList talesList;
  SelectionsList selectionsList;
}

class SaveChangedSelectionEvent extends SelectionsEvent {
  SaveChangedSelectionEvent({
    required this.selectionsList,
    required this.selection,
  });
  final Selection selection;
  final SelectionsList selectionsList;
}

class SearchAudioToAddInSelectionEvent extends SelectionsEvent {
  SearchAudioToAddInSelectionEvent({required this.value});
  String value;
}

class SelectSelectionsEvent extends SelectionsEvent {
  SelectSelectionsEvent({
    required this.audio,
  });
  final AudioTale audio;
}

class SelectSelectionsForListAudiosEvent extends SelectionsEvent {}

class CheckSelectionEvent extends SelectionsEvent {
  CheckSelectionEvent({
    required this.id,
  });
  final String id;
}

class SaveAudioWithSelectionsListEvent extends SelectionsEvent {
  SaveAudioWithSelectionsListEvent({
    required this.talesList,
  });
  final TalesList talesList;
}

class DisposeEvent extends SelectionsEvent {}

class DeleteSelectionEvent extends SelectionsEvent {
  DeleteSelectionEvent({
    required this.selection,
    required this.selectionsList,
    required this.talesList,
  });
  final TalesList talesList;
  final Selection selection;
  final SelectionsList selectionsList;
}
