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
      // return user;
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
      print('!!!!!!!!!!');
      return audiolistFromFirestore;
      // return list;
    } else {
      print('${id} !!!!!!!!!!!!!!!');
      // print(audiolistFromFirestore);
      return list;
    }
  }
}
