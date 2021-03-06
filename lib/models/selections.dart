import 'package:audiotales/models/selection.dart';
import 'package:audiotales/models/tale.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SelectionsList {
  SelectionsList({required this.selectionsList});
  factory SelectionsList.fromJson(Map<String, dynamic> json) {
    List listJson = json['selectionsList'];
    List<Selection> sList = listJson.map((e) => Selection.fromJson(e)).toList();

    return SelectionsList(selectionsList: sList);
  }

  factory SelectionsList.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    List listJson = snapshot.data()?['selectionsList'];
    List<Selection> sList =
        listJson.map((e) => Selection.fromFirestore(e)).toList();

    return SelectionsList(selectionsList: sList);
  }
  List<Selection> selectionsList;

  void addNewSelection(Selection selection) {
    selectionsList.insert(0, selection);
  }

  void replaceSelection({
    required Selection selection,
  }) {
    for (var sel in selectionsList) {
      if (sel.id == selection.id) {
        sel.replace(selection);
      }
    }
  }

  void deleteSelection({
    required Selection selection,
  }) {
    int index =
        selectionsList.indexWhere((element) => element.id == selection.id);
    selectionsList.removeAt(index);
  }

  Selection? getSelectionByAudioId(AudioTale audio) {
    var isAudioHaveCompilations = audio.selectionsId.isNotEmpty;
    final String id = isAudioHaveCompilations ? audio.selectionsId.last : '';
    List<Selection> _selectionsList =
        selectionsList.where((element) => element.id == id).toList();

    return _selectionsList.isNotEmpty ? _selectionsList.first : null;
  }

  Map<String, dynamic> toJson() => {
        'selectionsList': selectionsList.map((e) => e.toJson()).toList(),
      };

  Map<String, dynamic> toFirestore() {
    return {
      'selectionsList': selectionsList.map((e) => e.toFirestore()).toList(),
    };
  }

  void updateSelectionsList({required SelectionsList newSelectionsList}) {
    List<String> list1 = [];
    for (var e in selectionsList) {
      e.photoUrl = null;
      final Selection newSelection = newSelectionsList.selectionsList
          .firstWhere((element) => element.id == e.id, orElse: () => e);
      e.updateFromFB(newSelection);
      list1.add(e.id);
    }
    List<Selection> list = newSelectionsList.selectionsList
        .where((e) => list1.contains(e.id) ? false : true)
        .toList();
    selectionsList.addAll(list);
    selectionsList
        .sort((b, a) => int.parse(a.date).compareTo(int.parse(b.date)));
  }
}
