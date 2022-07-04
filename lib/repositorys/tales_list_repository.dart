import 'package:audiotales/data_base/data_base.dart';

import '../models/tales_list.dart';

class TalesListRepository {
  final DataBase db = DataBase.instance;
  TalesList getTalesListRepository() {
    TalesList talesListRep = db.getAudioTales();
    return talesListRep;
  }
}
