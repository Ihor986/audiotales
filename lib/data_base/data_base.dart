import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import '../models/audio.dart';
import '../models/selections.dart';
import '../models/tales_list.dart';
import '../models/user.dart';
import 'data/firestore_data_base.dart';
import 'data/local_data_base.dart';

class DataBase {
  const DataBase._();

  static const DataBase instance = DataBase._();
  static const String _userBox = 'userBox';

  Future<void> ensureInitialized() async {
    await _initializeHive();
    await _saveAudioTalesForUpDate();
    await _saveSelectionsListForUpDate();
    await _saveUserForUpDate();
  }

  LocalUser getUser() {
    final LocalUser _user = LocalDB.instance.getUser();
    return _user.isNewUser == null ? LocalUser(isNewUser: false) : _user;
  }

  Future<void> saveUser(LocalUser user) async {
    user.updateDate = DateTime.now().millisecondsSinceEpoch;
    LocalDB.instance.saveUserToLocalDB(user);
    if (user.isUserRegistered == true) {
      FirestoreDB.instance.saveUserToFirebase(user);
    }
  }

  Future<void> deleteUser() async {
    print('start');
    // await FirestoreDB.instance.deleteUser(user: getUser());
    LocalDB.instance.deleteUser();
    print('finish');
  }

  Future<void> saveUserWithUpDate() async {
    _saveUserForUpDate();
  }

  TalesList getAudioTales() {
    // _saveAudioTalesForUpDate();
    return LocalDB.instance.getAudioTales();
  }

  Future<void> saveAudioTales(TalesList _talesList) async {
    _deleteOldAudio(talesList: _talesList);
    LocalDB.instance.saveAudioTalesToLocalDB(_talesList);
    if (getUser().isUserRegistered == true) {
      FirestoreDB.instance
          .saveAudioTalesToFirebase(talesList: _talesList, user: getUser());
    }
  }

  _deleteOldAudio({
    required TalesList talesList,
  }) {
    int today = DateTime.now().millisecondsSinceEpoch.toInt();
    int howMenyDays = 86400000 * 2;
    TalesList _talesList = talesList;
    _talesList.fullTalesList.map(
      (element) {
        bool isPath = element.path == null && element.pathUrl == null;
        // bool isNotDeleted = !element.isDeleted;
        if (isPath) {
          DataBase.instance.deleteAudioTaleFromDB(element.id, _talesList);
        }
        if (element.deletedDate == null) {
          return element;
        }
        if (int.parse(element.deletedDate ?? '0') < today - howMenyDays) {
          DataBase.instance.deleteAudioTaleFromDB(element.id, _talesList);
        }
        return element;
      },
    ).toList();
  }

  Future<void> deleteAudioTaleFromDB(String id, TalesList talesList) async {
    TalesList _talesList = talesList;
    AudioTale _audioTale = _talesList.fullTalesList.firstWhere(
      (element) => element.id == id,
      orElse: () {
        return AudioTale(
            id: id,
            path: null,
            pathUrl: null,
            name: 'null',
            time: 0,
            size: 0,
            compilationsId: []);
      },
    );
    await FirestoreDB.instance.deleteAudioTaleFromFireBase(
        audioTale: _audioTale, userId: LocalDB.instance.getUser().id);
    LocalDB.instance.deleteAudioTaleFromLocalDB(_audioTale);
    _talesList.deleteAudio(id: id);
    await saveAudioTales(_talesList);
  }

  Future<void> saveAudioTalesWithUpDate() async {
    await _saveAudioTalesForUpDate();
  }

  SelectionsList getSelectionsList() {
    // _saveAudioTalesForUpDate();
    return LocalDB.instance.getSelectionsList();
  }

  Future<void> saveSelectionsList(SelectionsList _selectionsList) async {
    LocalDB.instance.saveSelectionsListToLocalDB(_selectionsList);
    if (getUser().isUserRegistered == true) {
      FirestoreDB.instance.saveSelectionsListToFirebase(
          selectionsList: _selectionsList, user: getUser());
    }
  }

  Future<void> saveSelectionsListWithUpDate() async {
    await _saveSelectionsListForUpDate();
  }

  Future<void> _initializeHive() async {
    Hive.init((await getApplicationDocumentsDirectory()).path);
    await Hive.openBox<String>(_userBox);
  }

  Future<void> _saveUserForUpDate() async {
    final bool auth = FirebaseAuth.instance.currentUser != null;
    if (auth) {
      final LocalUser user = LocalDB.instance.getUser();
      String? id = FirebaseAuth.instance.currentUser?.uid;
      final _firebaseUser =
          await FirestoreDB.instance.getUserFromFirestore(user: user, id: id);
      _firebaseUser.updateDate = DateTime.now().millisecondsSinceEpoch;
      final Box<String> userBox = Hive.box(_userBox);
      user.updateUser(newUser: _firebaseUser);
      await userBox.put('authUser', jsonEncode(user.toJson()));
    }
  }

  Future<void> _saveAudioTalesForUpDate() async {
    final bool auth = FirebaseAuth.instance.currentUser != null;
    if (auth) {
      final TalesList talesList = LocalDB.instance.getAudioTales();
      String? id = FirebaseAuth.instance.currentUser?.uid;
      final _firebaseTalesList = await FirestoreDB.instance.getAudioTales(
        id: id,
        list: talesList,
      );
      talesList.updateTalesList(newTalesList: _firebaseTalesList);
      if (talesList.fullTalesList == []) {
        return;
      }
      final Box<String> userBox = Hive.box(_userBox);
      await userBox.put('audiolist', jsonEncode(talesList.toJson()));
    }
  }

  Future<void> _saveSelectionsListForUpDate() async {
    final bool auth = FirebaseAuth.instance.currentUser != null;
    if (auth) {
      final SelectionsList selectionsList =
          LocalDB.instance.getSelectionsList();
      String? id = FirebaseAuth.instance.currentUser?.uid;
      final _firebaseSelectionsList =
          await FirestoreDB.instance.getSelectionsList(
        id: id,
        list: selectionsList,
      );
      selectionsList.updateSelectionsList(
          newSelectionsList: _firebaseSelectionsList);
      if (selectionsList.selectionsList == []) {
        return;
      }
      final Box<String> userBox = Hive.box(_userBox);
      await userBox.put('selectionsList', jsonEncode(selectionsList.toJson()));
    }
  }
}
