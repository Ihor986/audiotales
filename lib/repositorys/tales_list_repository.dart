import 'dart:convert';

import 'package:audiotales/data_base/data_base.dart';
import 'package:audiotales/models/audio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../data_base/data/firestore_data_base.dart';
import '../data_base/data/local_data_base.dart';
import '../models/tales_list.dart';

class TalesListRepository {
  // final _talesListRep = LocalDB.instance.getAudioTales();

  // TalesList getAudioTales() {
  //   String? id = FirebaseAuth.instance.currentUser?.uid;
  //   _saveAudioTalesForUpDate(
  //       firebaseTalesList: FirestoreDB.instance.getAudioTales(
  //         id: id,
  //         list: _talesListRep,
  //       ),
  //       talesList: _talesListRep);
  //   return _talesListRep;
  // }

  // Future<void> _saveAudioTalesForUpDate(
  //     {required Future<TalesList> firebaseTalesList,
  //     required TalesList talesList}) async {
  //   final bool auth = FirebaseAuth.instance.currentUser != null;
  //   if (auth) {
  //     final _firebaseTalesList = await firebaseTalesList;
  //     talesList.updateTalesList(newTalesList: _firebaseTalesList);
  //     // if (talesList.fullTalesList != []) {
  //     //   final Box<String> userBox = Hive.box('userBox');
  //     //   await userBox.put('audiolist', jsonEncode(talesList.toJson()));
  //     // }
  //   }
  // }

  // final TalesList _talesListRep = DataBase.instance.getAudioTales();

  TalesList getTalesListRepository() {
    TalesList talesListRep = DataBase.instance.getAudioTales();
    return talesListRep;
  }

  List<AudioTale> getActiveTalesList() {
    final bool auth = FirebaseAuth.instance.currentUser != null;
    if (auth) {
      List<AudioTale> activeTalesListRep = DataBase.instance
          .getAudioTales()
          .fullTalesList
          .where((element) => !element.isDeleted)
          .toList();
      return activeTalesListRep;
    } else {
      List<AudioTale> activeTalesListRep = DataBase.instance
          .getAudioTales()
          .fullTalesList
          .where((element) => !element.isDeleted && element.path != null)
          .toList();
      return activeTalesListRep;
    }
  }
}
