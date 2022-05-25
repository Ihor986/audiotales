import 'package:cloud_firestore/cloud_firestore.dart';

class SelectionsList {
  SelectionsList({required this.selectionsList});
  List<Selection> selectionsList;

  addNewAudio(Selection selection) {
    selectionsList.add(selection);
  }

  Map<String, dynamic> toJson() => {
        'talesList': selectionsList.map((e) => e.toJson()).toList(),
      };

  factory SelectionsList.fromJson(Map<String, dynamic> json) {
    List listJson = json['talesList'];
    List<Selection> sList = listJson.map((e) => Selection.fromJson(e)).toList();

    return SelectionsList(selectionsList: sList);
  }

  factory SelectionsList.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    List listJson = snapshot.data()?['talesList'];
    List<Selection> sList = listJson.map((e) => Selection.fromJson(e)).toList();

    return SelectionsList(selectionsList: sList);
  }

  Map<String, dynamic> toFirestore() {
    return {
      'talesList': selectionsList.map((e) => e.toJson()).toList(),
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
    required this.photo,
    required this.photoUrl,
    required this.description,
  });

  String id;
  String name;
  String photo;
  String photoUrl;
  String description;

  factory Selection.fromJson(Map<String, dynamic> json) {
    return Selection(
      id: json['id'] as String,
      name: json['name'] as String,
      photo: json['photo'] as String,
      photoUrl: json['photoUrl'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        // 'photo': photo,
        'photoUrl': photoUrl,
        'description': description,
      };
}
