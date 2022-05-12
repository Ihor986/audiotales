class AudioTale {
  AudioTale({
    required this.id,
    required this.path,
    required this.pathUrl,
    required this.name,
    required this.time,
    required this.size,
    this.compilationsId = const [],
    this.isDeleted = false,
  });

  final String id;
  final String name;
  final String? path;
  final String? pathUrl;
  final num time;
  final num size;
  List compilationsId;
  bool isDeleted;

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
    );
  }

  Map<String, dynamic> toJson() => {
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
