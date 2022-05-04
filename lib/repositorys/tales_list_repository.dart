import 'package:audiotales/models/audio.dart';

import '../data_base/local_data_base.dart';
import '../models/tales_list.dart';

class TalesListRepository {
  final TalesList _talesListRep = LocalDB.instance.getAudioTales();
  TalesList getTalesListRepository() {
    TalesList talesListRep = _talesListRep;
    return talesListRep;
  }

  List<AudioTale> getActiveTalesList() {
    List<AudioTale> activeTalesListRep = _talesListRep.fullTalesList
        .where((element) => !element.isDeleted)
        .toList();
    return activeTalesListRep;
  }
}
