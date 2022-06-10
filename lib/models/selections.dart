import 'package:cloud_firestore/cloud_firestore.dart';

class SelectionsList {
  SelectionsList({required this.selectionsList});
  List<Selection> selectionsList;

  addNewSelection(Selection selection) {
    selectionsList.insert(0, selection);
  }

  replaceSelection({
    required Selection selection,
  }) {
    for (var sel in selectionsList) {
      if (sel.id == selection.id) {
        sel.replace(selection);
      }
    }
  }

  Map<String, dynamic> toJson() => {
        'selectionsList': selectionsList.map((e) => e.toJson()).toList(),
      };

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
    List<Selection> sList = listJson.map((e) => Selection.fromJson(e)).toList();

    return SelectionsList(selectionsList: sList);
  }

  Map<String, dynamic> toFirestore() {
    return {
      'selectionsList': selectionsList.map((e) => e.toFirestore()).toList(),
    };
  }

  void updateSelectionsList({required SelectionsList newSelectionsList}) {
    List<String> list1 = [];
    for (var e in selectionsList) {
      final int oldUpdate = int.parse(e.updateDate ?? '0');
      final Selection newSelection = newSelectionsList.selectionsList
          .firstWhere((element) => element.id == e.id);
      final int newUpdate = int.parse(newSelection.updateDate ?? '0');
      if (newUpdate >= oldUpdate) {
        e.updateFromFB(newSelection);
      }
      list1.add(e.id);
    }
    List<Selection> list = newSelectionsList.selectionsList
        .where((e) => list1.contains(e.id) ? false : true)
        .toList();
    selectionsList.addAll(list);
  }
}

class Selection {
  Selection(
      {required this.id,
      required this.name,
      required this.date,
      this.photo,
      this.photoUrl,
      this.description,
      this.updateDate});

  String id;
  String name;
  String date;
  String? photo;
  String? photoUrl;
  String? description;
  String? updateDate;

  void replace(Selection selection) {
    id = selection.id;
    date = selection.date;
    photo = selection.photo;
    photoUrl = selection.photoUrl;
    description = selection.description;
    updateDate = selection.updateDate;
  }

  void updateFromFB(Selection selection) {
    name = selection.name;
    photoUrl = selection.photoUrl;
    description = selection.description;
    updateDate = selection.updateDate;
  }

  factory Selection.fromJson(Map<String, dynamic> json) {
    return Selection(
      id: json['id'] as String,
      name: json['name'] as String,
      date: json['date'] as String,
      photo: json['photo'],
      photoUrl: json['photoUrl'],
      description: json['description'],
      updateDate: json['updateDate'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'date': date,
        'photo': photo,
        'photoUrl': photoUrl,
        'description': description,
        'updateDate': updateDate,
      };
  Map<String, dynamic> toFirestore() => {
        'id': id,
        'name': name,
        'date': date,
        // 'photo': photo,
        'photoUrl': photoUrl,
        'description': description,
        'updateDate': updateDate,
      };
}
