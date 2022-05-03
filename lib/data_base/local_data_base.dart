import 'dart:convert';

// import 'package:file_structure_flutter/models/users/user_model.dart';
import 'package:audiotales/models/user.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../models/tales_list.dart';

// class _ClearStorage {
//   const _ClearStorage._();

//   static const _ClearStorage instance = _ClearStorage._();

//   Future<File> get _localFile async {
//     // final Directory directory = await getTemporaryDirectory();
//     final String path = Directory.current.path;
//     return File('$path/first_launch.txt');
//   }

//   Future<bool?> readLaunch() async {
//     try {
//       final File file = await _localFile;
//       final String content = await file.readAsString();
//       return content.isNotEmpty ? false : null;
//     } catch (e) {
//       return null;
//     }
//   }

//   Future<File> writeLaunch(bool launch) async {
//     final File file = await _localFile;
//     return file.writeAsString('$launch');
//   }
// }

class LocalDB {
  const LocalDB._();

  static const String _userBox = 'userBox';
  static const LocalDB instance = LocalDB._();

  Future<void> _initializeHive() async {
    Hive.init((await getApplicationDocumentsDirectory()).path);
    // final String path = Directory.current.path;
    // Hive.initFlutter();
    await Hive.openBox<String>(_userBox);
    // Hive.registerAdapter(User());
  }

  Future<void> ensureInitialized() async {
    await _initializeHive();
    // print('object');

    // const _ClearStorage clearStorage = _ClearStorage.instance;
    // final bool? isFirst = await clearStorage.readLaunch();

    // if (isFirst != null) return;

    // await saveUser( User());
    // await clearStorage.writeLaunch(false);
  }

  // [START] User

  Future<void> saveUser(User user) async {
    final Box<String> userBox = Hive.box(_userBox);
    await userBox.put('authUser', jsonEncode(user.toJson()));
    // print(User().toJson());
  }

  void deleteUser() async {
    final Box<String> userBox = Hive.box(_userBox);
    await userBox.delete('authUser');
  }

  User getUser() {
    // saveUser(User());

    // Hive.openBox<String>(_userBox);
    final Box<String> userBox = Hive.box(_userBox);
    return User.fromJson(
      jsonDecode(
          userBox.get('authUser', defaultValue: jsonEncode(User().toJson()))!),
    );
  }

  Future<void> saveAudioTales(TalesList talesList) async {
    if (talesList.getList != []) {
      final Box<String> userBox = Hive.box(_userBox);
      await userBox.put('audiolist', jsonEncode(talesList.toJson()));
    }
  }

  // TalesList getAudioTales() {
  //   final Box<String> userBox = Hive.box(_userBox);
  //   return TalesList.fromJson(
  //     jsonDecode(userBox.get('audiolist',
  //         defaultValue: jsonEncode(TalesList([]).toJson()))!),
  //   );
  // }

// [END] User
}
