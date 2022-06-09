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
  });

  final String id;
  final String name;
  final String? path;
  final String? pathUrl;
  final num time;
  final num size;
  final List compilationsId;
  bool isDeleted;
  String? deletedDate;

  factory AudioTale.fromJson(Map<String, dynamic> json) {
    // List i = json['compilationsId'];
    // List<String> y = i.map((e) => e.toString()).toList();

    // List _compilationsId = i.
    // print('$i iiiiiiiiiii');
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
    );
  }

  factory AudioTale.fromFirestore(Map<String, dynamic> json) {
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
    };
  }

  Map<String, dynamic> toFirestore() => {
        'id': id,
        'name': name,
        'path': path,
        'pathUrl': pathUrl,
        'time': time,
        'size': size,
        'compilationsId': compilationsId,
        'isDeleted': isDeleted,
        'deletedDate': deletedDate,
      };

  removeAudioToDeleted() {
    isDeleted = true;
    deletedDate = DateTime.now().millisecondsSinceEpoch.toString();
  }

  String getDeleteDate() {
    return deletedDate ?? '';
  }
}
