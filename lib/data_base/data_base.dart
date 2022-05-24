import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
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
    await _saveUserForUpDate();
  }

  LocalUser getUser() {
    final LocalUser _user = LocalDB.instance.getUser();
    // _saveUserForUpDate();
    return _user.isNewUser == null ? LocalUser(isNewUser: false) : _user;
  }

  Future<void> saveUser(LocalUser user) async {
    LocalDB.instance.saveUserToLocalDB(user);
    if (user.isUserRegistered == true) {
      FirestoreDB.instance.saveUserToFirebase(user);
    }
  }

  Future<void> saveUserWithUpDate() async {
    _saveUserForUpDate();
  }

  TalesList getAudioTales() {
    // _saveAudioTalesForUpDate();
    return LocalDB.instance.getAudioTales();
  }

  Future<void> saveAudioTales(TalesList _talesList) async {
    LocalDB.instance.saveAudioTalesToLocalDB(_talesList);
    if (getUser().isUserRegistered == true) {
      FirestoreDB.instance
          .saveAudioTalesToFirebase(talesList: _talesList, user: getUser());
    }
  }

  Future<void> saveAudioTalesWithUpDate() async {
    await _saveAudioTalesForUpDate();
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
}
