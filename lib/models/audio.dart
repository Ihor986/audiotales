class AudioTale {
  AudioTale(
      {required this.id,
      required this.path,
      required this.name,
      this.compilationsId = const ['head']});
  final String id;
  final String name;
  final String path;
  List compilationsId;

  factory AudioTale.fromJson(Map<String, dynamic> json) {
    return AudioTale(
      id: json['id'] as String,
      name: json['name'] as String,
      path: json['path'] as String,
      compilationsId: json['compilationsId'] as List,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'path': path,
        'compilationsId': compilationsId,
      };
}
