import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LocalUser {
  LocalUser({
    // this.photo,
    this.photoUrl,
    this.name,
    this.subscribe,
    this.id,
    this.updateDate,
    this.isNewUser,
    this.isUserRegistered,
  });

  User? currentUser = FirebaseAuth.instance.currentUser;
  // String? photo;
  String? photoUrl;
  String? name;
  String? subscribe;
  String? id;
  int? updateDate;
  bool? isNewUser;
  bool? isUserRegistered;

  factory LocalUser.fromJson(Map<String, dynamic> json) {
    return LocalUser(
      // photo: json['photo'],
      photoUrl: json['photoUrl'],
      name: json['name'],
      subscribe: json['subscribe'],
      id: json['id'],
      updateDate: json['updateDate'],
      isNewUser: json['isNewUser'],
      isUserRegistered: json['isUserRegistered'],
    );
  }

  LocalUser.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  )   :
        // photo = snapshot.data()?['photo'],
        photoUrl = snapshot.data()?['photoUrl'],
        name = snapshot.data()?['name'],
        subscribe = snapshot.data()?['subscribe'],
        id = snapshot.data()?['id'],
        updateDate = snapshot.data()?['updateDate'],
        isNewUser = snapshot.data()?['isNewUser'],
        isUserRegistered = snapshot.data()?['isUserRegistered'];

  Map<String, dynamic> toJson() => {
        // 'photo': photo,
        'photoUrl': photoUrl,
        'name': name,
        'subscribe': subscribe,
        'id': id,
        'updateDate': updateDate,
        'isNewUser': isNewUser,
        'isUserRegistered': isUserRegistered,
      };

  Map<String, dynamic> toFirestore() {
    return {
      // 'photo': photo,
      'photoUrl': photoUrl,
      'name': name,
      'subscribe': subscribe,
      'id': id,
      'updateDate': updateDate,
      'isNewUser': isNewUser,
      'isUserRegistered': isUserRegistered,
    };
  }

  updateUser({required LocalUser newUser}) {
    if (newUser.updateDate == null || updateDate == null) return;
    if (updateDate! > newUser.updateDate!) return;
    photoUrl = newUser.photoUrl;
    name = newUser.name;
    subscribe = newUser.subscribe;
    id = newUser.id;
    updateDate = newUser.updateDate;
    isNewUser = newUser.isNewUser;
    isUserRegistered = newUser.isUserRegistered;
  }

  changeUserFields({
    String? nName,
    String? nSubscribe,
  }) {
    name = nName ?? name;
    subscribe = nSubscribe ?? subscribe;
  }
}
