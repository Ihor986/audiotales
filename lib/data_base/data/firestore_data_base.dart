import 'package:audiotales/models/audio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../models/selections.dart';
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

  Future<SelectionsList> getSelectionsList(
      {required SelectionsList list, required String? id}) async {
    final ref = FirebaseFirestore.instance
        .collection('$id')
        .doc('selectionsList')
        .withConverter(
          fromFirestore: SelectionsList.fromFirestore,
          toFirestore: (SelectionsList selectionsListFromFirestore, _) =>
              selectionsListFromFirestore.toFirestore(),
        );

    final docSnap = await ref.get();
    final selectionsListFromFirestore = docSnap.data();
    if (selectionsListFromFirestore != null) {
      return selectionsListFromFirestore;
    } else {
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

  Future<void> saveSelectionsListToFirebase(
      {required SelectionsList selectionsList, required LocalUser user}) async {
    try {
      await FirebaseFirestore.instance
          .collection(user.id!)
          .doc('selectionsList')
          .set(selectionsList.toFirestore());
    } catch (_) {}
  }

  Future<void> deleteAudioTaleFromFireBase(
      {required AudioTale audioTale, required String? userId}) async {
    if (audioTale.pathUrl == null) {
      return;
    }
    await FirebaseStorage.instance
        .ref()
        .child('$userId/audio/')
        .child(audioTale.id)
        .delete();
  }

  Future<void> deleteUser({required LocalUser user}) async {
    try {
      await FirebaseStorage.instance.ref('${user.id}/audio/').listAll().then(
        (value) {
          for (var element in value.items) {
            FirebaseStorage.instance.ref(element.fullPath).delete();
          }
        },
      );

      await FirebaseStorage.instance
          .ref('${user.id}/images/avatar')
          .listAll()
          .then(
        (value) {
          for (var element in value.items) {
            FirebaseStorage.instance.ref(element.fullPath).delete();
          }
        },
      );

      await FirebaseStorage.instance
          .ref('${user.id}/images/selections_photo')
          .listAll()
          .then(
        (value) {
          for (var element in value.items) {
            FirebaseStorage.instance.ref(element.fullPath).delete();
          }
        },
      );
    } catch (_) {}

    try {
      await FirebaseFirestore.instance
          .collection(user.id!)
          .get()
          .then((snapshot) {
        for (DocumentSnapshot ds in snapshot.docs) {
          ds.reference.delete();
        }
      });
    } catch (_) {}

    try {
      await user.currentUser?.delete();
    } catch (_) {}
  }
}
