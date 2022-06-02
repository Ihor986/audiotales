import 'package:cloud_firestore/cloud_firestore.dart';

class SelectionsList {
  SelectionsList({required this.selectionsList});
  List<Selection> selectionsList;

  addNewSelection(Selection selection) {
    selectionsList.insert(0, selection);
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
      list1.add(e.id);
    }
    List<Selection> list = newSelectionsList.selectionsList
        .where((e) => list1.contains(e.id) ? false : true)
        .toList();
    selectionsList.addAll(list);
  }
}

class Selection {
  Selection({
    required this.id,
    required this.name,
    required this.date,
    this.photo,
    this.photoUrl,
    this.description,
  });

  String id;
  String name;
  String date;
  String? photo;
  String? photoUrl;
  String? description;

  factory Selection.fromJson(Map<String, dynamic> json) {
    return Selection(
      id: json['id'] as String,
      name: json['name'] as String,
      date: json['date'] as String,
      photo: json['photo'],
      photoUrl: json['photoUrl'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'date': date,
        'photo': photo,
        'photoUrl': photoUrl,
        'description': description,
      };
  Map<String, dynamic> toFirestore() => {
        'id': id,
        'name': name,
        'date': date,
        // 'photo': photo,
        'photoUrl': photoUrl,
        'description': description,
      };
}
