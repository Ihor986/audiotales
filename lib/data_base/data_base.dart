import 'dart:convert';
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
  static const String _userBoxName = 'userBox';
  static const FirestoreDB _firestoreDB = FirestoreDB.instance;
  static const LocalDB _locaDB = LocalDB.instance;

  Future<void> ensureInitialized() async {
    await _initializeHive();
    await _saveAudioTalesForUpDate();
    await _saveSelectionsListForUpDate();
    await _saveUserForUpDate();
  }

  LocalUser getUser() {
    final LocalUser _user = _locaDB.getUser();
    return _user.isNewUser == null ? LocalUser(isNewUser: false) : _user;
  }

  Future<void> saveUser(LocalUser user) async {
    user.updateDate = DateTime.now().millisecondsSinceEpoch;
    _locaDB.saveUserToLocalDB(user);
    if (user.currentUser == null) return;
    await _firestoreDB.saveUserToFirebase(user);
  }

  Future<void> deleteUser() async {
    await _firestoreDB.deleteUser(user: getUser());
    _locaDB.deleteUser();
  }

  Future<void> saveUserWithUpDate() async {
    await _saveUserForUpDate();
  }

  TalesList getAudioTales() {
    return _locaDB.getAudioTales();
  }

  Future<void> deleteAudioTaleFromDB(
      List<String> idList, TalesList talesList) async {
    await _deleteAudioTaleFromDB(idList, talesList);
  }

  Future<void> saveAudioTales(TalesList _talesList) async {
    await _deleteOldAudio(talesList: _talesList);
    _locaDB.saveAudioTalesToLocalDB(_talesList);
    final LocalUser _user = _locaDB.getUser();
    if (_user.currentUser == null) return;
    await _firestoreDB.saveAudioTalesToFirebase(
        talesList: _talesList, user: getUser());
  }

  Future<void> _deleteOldAudio({
    required TalesList talesList,
  }) async {
    int today = DateTime.now().millisecondsSinceEpoch.toInt();
    int howMenyDays = 86400000 * 15;
    TalesList _talesList = talesList;
    List<AudioTale> _deleteOldAudioList =
        _talesList.fullTalesList.where((element) {
      bool isNoPath = element.path == null && element.pathUrl == null;
      bool isToOld = int.parse(element.deletedDate ?? today.toString()) <
          today - howMenyDays;
      return isNoPath || isToOld ? true : false;
    }).toList();
    if (_deleteOldAudioList.isEmpty) return;
    List<String> idList = _deleteOldAudioList.map((e) => e.id).toList();
    await _deleteAudioTaleFromDB(idList, talesList);
  }

  Future<void> _deleteAudioTaleFromDB(
      List<String> idList, TalesList talesList) async {
    final TalesList _talesList = talesList;

    for (var id in idList) {
      List<AudioTale> aList = _talesList.fullTalesList
          .where((element) => element.id == id)
          .toList();
      if (aList.isEmpty) continue;
      final AudioTale _audioTale = aList.first;
      await _firestoreDB.deleteAudioTaleFromFireBase(
        audioTale: _audioTale,
        userId: _locaDB.getUser().id,
      );
      _locaDB.deleteAudioTaleFromLocalDB(_audioTale);
      _talesList.deleteAudio(id: id);
    }
    await saveAudioTales(_talesList);
  }

  Future<void> saveAudioTalesWithUpDate() async {
    await _saveAudioTalesForUpDate();
  }

  SelectionsList getSelectionsList() {
    return _locaDB.getSelectionsList();
  }

  Future<void> saveSelectionsList(SelectionsList _selectionsList) async {
    _locaDB.saveSelectionsListToLocalDB(_selectionsList);
    final LocalUser _user = _locaDB.getUser();
    if (_user.currentUser == null) return;
    await _firestoreDB.saveSelectionsListToFirebase(
      selectionsList: _selectionsList,
      user: _user,
    );
  }

  Future<void> saveSelectionsListWithUpDate() async {
    await _saveSelectionsListForUpDate();
  }

  Future<void> _initializeHive() async {
    Hive.init((await getApplicationDocumentsDirectory()).path);
    await Hive.openBox<String>(_userBoxName);
  }

  Future<void> _saveUserForUpDate() async {
    final LocalUser _user = _locaDB.getUser();
    if (_user.currentUser == null) return;
    final String? id = _user.currentUser?.uid;
    final _firebaseUser =
        await _firestoreDB.getUserFromFirestore(user: _user, id: id);
    _user.updateUser(newUser: _firebaseUser);
    saveUser(_user);
  }

  Future<void> _saveAudioTalesForUpDate() async {
    final LocalUser _user = _locaDB.getUser();
    if (_user.currentUser == null) return;
    final TalesList _talesList = _locaDB.getAudioTales();
    String? id = _user.currentUser?.uid;
    final _firebaseTalesList = await _firestoreDB.getAudioTales(
      id: id,
      list: _talesList,
    );
    _talesList.updateTalesList(newTalesList: _firebaseTalesList);
    if (_talesList.fullTalesList == []) return;

    final Box<String> _userBox = Hive.box(_userBoxName);
    await _userBox.put('audiolist', jsonEncode(_talesList.toJson()));
  }

  Future<void> _saveSelectionsListForUpDate() async {
    final LocalUser _user = _locaDB.getUser();
    if (_user.currentUser == null) return;
    final SelectionsList _selectionsList = _locaDB.getSelectionsList();
    String? id = _user.currentUser?.uid;
    final _firebaseSelectionsList = await _firestoreDB.getSelectionsList(
      id: id,
      list: _selectionsList,
    );
    _selectionsList.updateSelectionsList(
      newSelectionsList: _firebaseSelectionsList,
    );
    if (_selectionsList.selectionsList == []) return;
    saveSelectionsList(_selectionsList);
  }
}
