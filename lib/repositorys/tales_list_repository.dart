import 'package:audiotales/data_base/data_base.dart';

import '../models/tales_list.dart';

class TalesListRepository {
  final DataBase db = DataBase.instance;
  TalesList getTalesListRepository() {
    TalesList talesListRep = db.getAudioTales();
    return talesListRep;
  }

  // List<AudioTale> getActiveTalesList() {
  //   final bool auth = FirebaseAuth.instance.currentUser != null;
  //   if (auth) {
  //     List<AudioTale> activeTalesListRep = DataBase.instance
  //         .getAudioTales()
  //         .fullTalesList
  //         .where((element) => !element.isDeleted)
  //         .toList();
  //     return activeTalesListRep;
  //   } else {
  //     List<AudioTale> activeTalesListRep = DataBase.instance
  //         .getAudioTales()
  //         .fullTalesList
  //         .where((element) => !element.isDeleted && element.path != null)
  //         .toList();
  //     return activeTalesListRep;
  //   }
  // }
}
