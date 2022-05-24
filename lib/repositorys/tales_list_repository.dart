import 'package:audiotales/data_base/data_base.dart';
import 'package:audiotales/models/audio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/tales_list.dart';

class TalesListRepository {
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
