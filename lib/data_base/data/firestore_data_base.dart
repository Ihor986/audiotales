import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/tales_list.dart';
import '../../models/user.dart';

class FirestoreDB {
  const FirestoreDB._();

  static const FirestoreDB instance = FirestoreDB._();
  Future<LocalUser> getUserFromFirestore(
      {required LocalUser user, required String? id}) async {
    final ref = FirebaseFirestore.instance
        .collection('$id')
        .doc('authUser')
        .withConverter(
          fromFirestore: LocalUser.fromFirestore,
          toFirestore: (LocalUser localUserFromFirestore, _) =>
              localUserFromFirestore.toFirestore(),
        );
    final docSnap = await ref.get();
    final localUserFromFirestore = docSnap.data();
    if (localUserFromFirestore != null) {
      return localUserFromFirestore;
    } else {
      return user;
    }
  }

  Future<TalesList> getAudioTales(
      {required TalesList list, required String? id}) async {
    final ref = FirebaseFirestore.instance
        .collection('$id')
        .doc('audiolist')
        .withConverter(
          fromFirestore: TalesList.fromFirestore,
          toFirestore: (TalesList audiolistFromFirestore, _) =>
              audiolistFromFirestore.toFirestore(),
        );

    final docSnap = await ref.get();
    final audiolistFromFirestore = docSnap.data();
    if (audiolistFromFirestore != null) {
      // print(audiolistFromFirestore.fullTalesList.first.compilationsId);
      return audiolistFromFirestore;
    } else {
      // print('${list.fullTalesList.first.compilationsId} !!!!!!!!!');
      return list;
    }
  }

  saveUserToFirebase(LocalUser _user) async {
    if (_user.isUserRegistered == true) {
      try {
        await FirebaseFirestore.instance
            .collection(_user.id!)
            .doc('authUser')
            .set(_user.toJson());
      } catch (_) {}
    }
  }

  Future<void> saveAudioTalesToFirebase(
      {required TalesList talesList, required LocalUser user}) async {
    try {
      await FirebaseFirestore.instance
          .collection(user.id!)
          .doc('audiolist')
          .set(talesList.toFirestore());
    } catch (_) {}
  }
}
