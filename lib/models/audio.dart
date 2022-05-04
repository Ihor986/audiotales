class AudioTale {
  AudioTale(
      {required this.id,
      required this.path,
      required this.name,
      required this.time,
      this.compilationsId = const ['head'],
      this.isDeleted = false});
  final String id;
  final String name;
  final String path;
  final num time;
  List compilationsId;
  final bool isDeleted;

  factory AudioTale.fromJson(Map<String, dynamic> json) {
    return AudioTale(
      id: json['id'] as String,
      name: json['name'] as String,
      path: json['path'] as String,
      time: json['time'] as num,
      compilationsId: json['compilationsId'] as List,
      isDeleted: json['isDeleted'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'path': path,
        'time': time,
        'compilationsId': compilationsId,
        'isDeleted': isDeleted,
      };
}
