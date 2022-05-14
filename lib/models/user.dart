import 'package:cloud_firestore/cloud_firestore.dart';

class LocalUser {
  LocalUser({
    this.photo,
    this.photoUrl,
    this.name,
    this.phone,
    this.id,
    this.updateDate,
    this.isNewUser,
    this.isUserRegistered,
  });
  String? photo;
  String? photoUrl;
  String? name;
  String? phone;
  String? id;
  int? updateDate;
  bool? isNewUser;
  bool? isUserRegistered;

  // void deleteAccount() {
  //   photo = null;
  //   photoUrl = null;
  //   name = null;
  //   phone = null;
  //   id = null;
  // }

  factory LocalUser.fromJson(Map<String, dynamic> json) {
    return LocalUser(
      photo: json['photo'],
      photoUrl: json['photoUrl'],
      name: json['name'],
      phone: json['phone'],
      id: json['id'],
      updateDate: json['updateDate'],
      isNewUser: json['isNewUser'],
      isUserRegistered: json['isUserRegistered'],
    );
  }

  LocalUser.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  )   : photo = snapshot.data()?['photo'],
        photoUrl = snapshot.data()?['photoUrl'],
        name = snapshot.data()?['name'],
        phone = snapshot.data()?['phone'],
        id = snapshot.data()?['id'],
        updateDate = snapshot.data()?['updateDate'],
        isNewUser = snapshot.data()?['isNewUser'],
        isUserRegistered = snapshot.data()?['isUserRegistered'];

  Map<String, dynamic> toJson() => {
        'photo': photo,
        'photoUrl': photoUrl,
        'name': name,
        'phone': phone,
        'id': id,
        'updateDate': updateDate,
        'isNewUser': isNewUser,
        'isUserRegistered': isUserRegistered,
      };

  Map<String, dynamic> toFirestore() {
    return {
      'photo': photo,
      'photoUrl': photoUrl,
      'name': name,
      'phone': phone,
      'id': id,
      'updateDate': updateDate,
      'isNewUser': isNewUser,
      'isUserRegistered': isUserRegistered,
    };
  }

  updateUser({
    required LocalUser newUser,
  }) {
    // photo = photo;
    photoUrl = newUser.photoUrl;
    name = newUser.name;
    phone = newUser.phone;
    id = newUser.id;
    updateDate = newUser.updateDate;
    isNewUser = newUser.isNewUser;
    isUserRegistered = newUser.isUserRegistered;
  }
}
