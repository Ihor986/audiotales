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
  });

  final String id;
  final String name;
  final String? path;
  final String? pathUrl;
  final num time;
  final num size;
  final List compilationsId;
  bool isDeleted;

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
      };
}
