class Selection {
  Selection(
      {required this.id,
      required this.name,
      required this.date,
      this.photo,
      this.photoUrl,
      this.description,
      this.updateDate});

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

  factory Selection.fromFirestore(Map<String, dynamic> json) {
    return Selection(
      id: json['id'] as String,
      name: json['name'] as String,
      date: json['date'] as String,
      photo: null,
      photoUrl: json['photoUrl'],
      description: json['description'],
      updateDate: json['updateDate'],
    );
  }

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
    final int newUpdate = int.parse(selection.updateDate ?? '0');
    final int oldUpdate = int.parse(updateDate ?? '0');
    photoUrl = selection.photoUrl;
    if (newUpdate <= oldUpdate) return;
    name = selection.name;
    photoUrl = selection.photoUrl;
    description = selection.description;
    updateDate = selection.updateDate;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'date': date,
        'photo': photo,
        'photoUrl': photoUrl,
        'description': description,
        'updateDate': DateTime.now().millisecondsSinceEpoch.toString(),
      };

  Map<String, dynamic> toFirestore() => {
        'id': id,
        'name': name,
        'date': date,
        // 'photo': photo,
        'photoUrl': photoUrl,
        'description': description,
        'updateDate': DateTime.now().millisecondsSinceEpoch.toString(),
      };
}
