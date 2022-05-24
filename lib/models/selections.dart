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

class SelectionsList {
  SelectionsList(this.selectionsList);
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

    return SelectionsList(sList);
  }
}
