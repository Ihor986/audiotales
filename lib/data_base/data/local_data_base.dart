import 'dart:convert';
import 'package:audiotales/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import '../../models/tales_list.dart';

class LocalDB {
  const LocalDB._();

  static const String _userBox = 'userBox';
  static const LocalDB instance = LocalDB._();

  Future<void> _initializeHive() async {
    Hive.init((await getApplicationDocumentsDirectory()).path);
    await Hive.openBox<String>(_userBox);
  }

  Future<void> ensureInitialized() async {
    await _initializeHive();
  }

  Future<void> saveUser(Future<LocalUser> user) async {
    final _user = await user;
    _user.updateDate = DateTime.now().millisecondsSinceEpoch;
    final Box<String> userBox = Hive.box(_userBox);
    await userBox.put('authUser', jsonEncode(_user.toJson()));
    try {
      FirebaseFirestore.instance
          .collection(_user.id!)
          .doc('authUser')
          .set(_user.toJson());
    } catch (_) {}
  }

  void deleteUser() async {
    final Box<String> userBox = Hive.box(_userBox);
    await userBox.delete('authUser');
  }

  LocalUser getUser() {
    final Box<String> userBox = Hive.box(_userBox);
    // userBox.delete('authUser');
    // return;
    return LocalUser.fromJson(
      jsonDecode(userBox.get('authUser',
          defaultValue: jsonEncode(LocalUser().toJson()))!),
    );
  }

  Future<void> saveAudioTales(Future<TalesList> talesList) async {
    final _talesList = await talesList;
    if (_talesList.fullTalesList != []) {
      final Box<String> userBox = Hive.box(_userBox);
      await userBox.put('audiolist', jsonEncode(_talesList.toJson()));

      try {
        FirebaseFirestore.instance
            .collection(getUser().id!)
            .doc('audiolist')
            .set(_talesList.toFirestore());
      } catch (_) {}
    }
  }

  TalesList getAudioTales() {
    final Box<String> userBox = Hive.box(_userBox);
    // userBox.delete('audiolist');
    // return TalesList(fullTalesList: []);
    return TalesList.fromJson(
      jsonDecode(userBox.get('audiolist',
          defaultValue: jsonEncode(TalesList(fullTalesList: []).toJson()))!),
    );
  }
}
