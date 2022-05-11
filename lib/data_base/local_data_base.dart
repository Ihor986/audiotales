import 'dart:convert';
import 'package:audiotales/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import '../models/tales_list.dart';

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

  Future<void> saveUser(LocalUser user) async {
    final Box<String> userBox = Hive.box(_userBox);
    await userBox.put('authUser', jsonEncode(user.toJson()));
    try {
      // FirebaseFirestore.instance.
      FirebaseFirestore.instance
          .collection(user.id!)
          .doc('authUser')
          .set(user.toJson());
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

  Future<void> saveAudioTales(TalesList talesList) async {
    if (talesList.fullTalesList != []) {
      final Box<String> userBox = Hive.box(_userBox);
      await userBox.put('audiolist', jsonEncode(talesList.toJson()));

      try {
        FirebaseFirestore.instance
            .collection(getUser().id!)
            .doc('audiolist')
            .set(talesList.toJson());
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
