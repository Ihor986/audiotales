import 'dart:convert';
import 'dart:io';
import 'package:audiotales/models/user.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/audio.dart';
import '../../models/selections.dart';
import '../../models/tales_list.dart';

class LocalDB {
  const LocalDB._();

  static const String _userBox = 'userBox';
  static const LocalDB instance = LocalDB._();

  LocalUser getUser() {
    final Box<String> userBox = Hive.box(_userBox);
    return LocalUser.fromJson(
      jsonDecode(userBox.get('authUser',
          defaultValue: jsonEncode(LocalUser().toJson()))!),
    );
  }

  TalesList getAudioTales() {
    final Box<String> userBox = Hive.box(_userBox);
    return TalesList.fromJson(
      jsonDecode(userBox.get('audiolist',
          defaultValue: jsonEncode(TalesList(fullTalesList: []).toJson()))!),
    );
  }

  SelectionsList getSelectionsList() {
    final Box<String> userBox = Hive.box(_userBox);
    return SelectionsList.fromJson(
      jsonDecode(userBox.get('selectionsList',
          defaultValue:
              jsonEncode(SelectionsList(selectionsList: []).toJson()))!),
    );
  }

  Future<void> saveUserToLocalDB(LocalUser _user) async {
    final Box<String> userBox = Hive.box(_userBox);
    await userBox.put('authUser', jsonEncode(_user.toJson()));
  }

  Future<void> saveAudioTalesToLocalDB(TalesList _talesList) async {
    if (_talesList.fullTalesList != []) {
      final Box<String> userBox = Hive.box(_userBox);
      await userBox.put('audiolist', jsonEncode(_talesList.toJson()));
    }
  }

  Future<void> saveSelectionsListToLocalDB(
      SelectionsList _selectionsList) async {
    if (_selectionsList.selectionsList != []) {
      final Box<String> userBox = Hive.box(_userBox);
      await userBox.put('selectionsList', jsonEncode(_selectionsList.toJson()));
    }
  }

  Future<void> deleteUser() async {
    final TalesList _talesList = getAudioTales();
    final SelectionsList _selectionsList = getSelectionsList();
    final Box<String> userBox = Hive.box(_userBox);
    for (var item in _talesList.fullTalesList) {
      item.pathUrl = null;
    }
    saveAudioTalesToLocalDB(_talesList);
    for (var item in _selectionsList.selectionsList) {
      item.photoUrl = null;
    }
    saveSelectionsListToLocalDB(_selectionsList);
    await userBox.delete('authUser');
  }

  void deleteAudioTaleFromLocalDB(AudioTale audioTale) {
    if (audioTale.path == null) return;
    try {
      File(audioTale.path!).delete();
    } catch (_) {}
  }
}
