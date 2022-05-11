class LocalUser {
  LocalUser({
    this.photo,
    this.photoUrl,
    this.name,
    this.phone,
    this.id,
    this.isNewUser,
    this.isUserRegistered,
  });
  String? photo;
  String? photoUrl;
  String? name;
  String? phone;
  String? id;
  bool? isNewUser;
  bool? isUserRegistered;
  // List<String> audio;

  void deleteAccount() {
    photo = null;
    photoUrl = null;
    name = null;
    phone = null;
    id = null;
  }

  factory LocalUser.fromJson(Map<String, dynamic> json) {
    return LocalUser(
      photo: json['photo'],
      photoUrl: json['photoUrl'],
      name: json['name'],
      phone: json['phone'],
      id: json['id'],
      isNewUser: json['isNewUser'],
      isUserRegistered: json['isUserRegistered'],
      // audio: json['audio'].split(""),
    );
  }
  Map<String, dynamic> toJson() => {
        'photo': photo,
        'photoUrl': photoUrl,
        'name': name,
        'phone': phone,
        'id': id,
        'isNewUser': isNewUser,
        'isUserRegistered': isUserRegistered,
        // 'audio': audio.toString(),
      };
}
