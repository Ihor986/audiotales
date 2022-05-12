import 'package:audiotales/data_base/data_base.dart';
import 'package:audiotales/models/audio.dart';

import '../models/tales_list.dart';

class TalesListRepository {
  final TalesList _talesListRep = DataBase.instance.getAudioTales();

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
