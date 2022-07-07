class AudioTale {
  AudioTale({
    required this.id,
    required this.path,
    required this.pathUrl,
    required this.name,
    required this.time,
    required this.size,
    required this.compilationsId,
    this.isDeleted = false,
    this.deletedDate,
    this.updateDate,
  });

  final String id;
  String name;

  String? path;
  String? pathUrl;
  final num time;
  final num size;
  List compilationsId;
  bool isDeleted;
  String? deletedDate;
  String? updateDate;

  factory AudioTale.fromJson(Map<String, dynamic> json) {
    return AudioTale(
      id: json['id'],
      name: json['name'],
      path: json['path'],
      pathUrl: json['pathUrl'],
      time: json['time'],
      size: json['size'],
      compilationsId: json['compilationsId'],
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
      compilationsId: json['compilationsId'],
      isDeleted: json['isDeleted'],
      deletedDate: json['deletedDate'],
      updateDate: json['updateDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'path': path,
      'pathUrl': pathUrl,
      'time': time,
      'size': size,
      'compilationsId': compilationsId.map((e) => e).toList(),
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
        'compilationsId': compilationsId,
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
    compilationsId = newAudio.compilationsId;
    isDeleted = newAudio.isDeleted;
    deletedDate = newAudio.deletedDate;
    updateDate = newAudio.updateDate;
  }

  void updateAudio({
    String? nName,
    List? nCompilationsId,
    bool? nIsDeleted,
    String? nDeletedDate,
    String? nUpdateDate,
    List? addCompilationsId,
    String? nPath,
    // String? nPathUrl,
    // num? nTime,
    // num? nSize,
  }) {
    name = nName ?? name;
    path = nPath ?? path;
    compilationsId = nCompilationsId ?? compilationsId;
    isDeleted = nIsDeleted ?? isDeleted;
    deletedDate = nIsDeleted == true
        ? DateTime.now().millisecondsSinceEpoch.toString()
        : deletedDate;
    updateDate = DateTime.now().millisecondsSinceEpoch.toString();
    if (addCompilationsId == null) return;
    for (var item in addCompilationsId) {
      final bool isNoContain = !compilationsId.contains(item);
      if (isNoContain) {
        compilationsId.add(item);
      }
    }
    // final String? path;
    // pathUrl = nPathUrl ?? pathUrl;
    // final num time;
    // final num size;
  }

  // removeAudioToDeleted() {
  //   isDeleted = true;
  //   deletedDate = DateTime.now().millisecondsSinceEpoch.toString();
  // }

}
