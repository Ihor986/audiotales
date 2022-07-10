class AudioTale {
  AudioTale({
    required this.id,
    required this.path,
    required this.pathUrl,
    required this.name,
    required this.time,
    required this.size,
    required this.selectionsId,
    this.isDeleted = false,
    this.deletedDate,
    this.updateDate,
  });

  factory AudioTale.fromJson(Map<String, dynamic> json) {
    return AudioTale(
      id: json['id'],
      name: json['name'],
      path: json['path'],
      pathUrl: json['pathUrl'],
      time: json['time'],
      size: json['size'],
      selectionsId: json['compilationsId'],
      isDeleted: json['isDeleted'],
      deletedDate: json['deletedDate'],
      updateDate: json['updateDate'],
    );
  }

  factory AudioTale.fromFirestore(Map<String, dynamic> json) {
    return AudioTale(
      id: json['id'],
      name: json['name'],
      path: null,
      pathUrl: json['pathUrl'],
      time: json['time'],
      size: json['size'],
      selectionsId: json['compilationsId'],
      isDeleted: json['isDeleted'],
      deletedDate: json['deletedDate'],
      updateDate: json['updateDate'],
    );
  }

  final String id;
  String name;
  String? path;
  String? pathUrl;
  final num time;
  final num size;
  List selectionsId;
  bool isDeleted;
  String? deletedDate;
  String? updateDate;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'path': path,
      'pathUrl': pathUrl,
      'time': time,
      'size': size,
      'compilationsId': selectionsId.map((e) => e).toList(),
      'isDeleted': isDeleted,
      'deletedDate': deletedDate,
      'updateDate': DateTime.now().millisecondsSinceEpoch.toString(),
    };
  }

  Map<String, dynamic> toFirestore() => {
        'id': id,
        'name': name,
        // 'path': path,
        'pathUrl': pathUrl,
        'time': time,
        'size': size,
        'compilationsId': selectionsId,
        'isDeleted': isDeleted,
        'deletedDate': deletedDate,
        'updateDate': DateTime.now().millisecondsSinceEpoch.toString(),
      };

  String getDeleteDate() {
    return deletedDate ?? '';
  }

  void updateFromFB(AudioTale newAudio) {
    final int newUpdate = int.parse(newAudio.updateDate ?? '0');
    final int oldUpdate = int.parse(updateDate ?? '0');
    pathUrl = newAudio.pathUrl;
    if (newUpdate <= oldUpdate) return;
    name = newAudio.name;
    selectionsId = newAudio.selectionsId;
    isDeleted = newAudio.isDeleted;
    deletedDate = newAudio.deletedDate;
    updateDate = newAudio.updateDate;
  }

  void updateAudio({
    String? nName,
    List? nSelectionsId,
    bool? nIsDeleted,
    String? nDeletedDate,
    String? nUpdateDate,
    List? addSelectionsId,
    String? nPath,
  }) {
    name = nName ?? name;
    path = nPath ?? path;
    selectionsId = nSelectionsId ?? selectionsId;
    isDeleted = nIsDeleted ?? isDeleted;
    deletedDate = nIsDeleted == true
        ? DateTime.now().millisecondsSinceEpoch.toString()
        : deletedDate;
    updateDate = DateTime.now().millisecondsSinceEpoch.toString();
    if (addSelectionsId == null) return;
    for (var item in addSelectionsId) {
      final bool isNoContain = !selectionsId.contains(item);
      if (isNoContain) {
        selectionsId.add(item);
      }
    }
  }
}
