class User {
  User(
      {this.photo = '',
      this.name = '',
      this.phone = '',
      this.id = '',
      this.isNewUser = true});
  String photo;
  String name;
  String phone;
  String id;
  bool isNewUser;
  // List<String> audio;

  void deleteAccount() {
    photo = '';
    name = '';
    phone = '';
    id = '';
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      photo: json['photo'],
      name: json['name'],
      phone: json['phone'],
      id: json['id'],
      isNewUser: json['isNewUser'],
      // audio: json['audio'].split(""),
    );
  }
  Map<String, dynamic> toJson() => {
        'photo': photo,
        'name': name,
        'phone': phone,
        'id': id,
        'isNewUser': isNewUser,
        // 'audio': audio.toString(),
      };
}
