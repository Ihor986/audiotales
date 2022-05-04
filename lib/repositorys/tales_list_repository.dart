import '../data_base/local_data_base.dart';
import '../models/tales_list.dart';

class TalesListRepository {
  TalesList _talesListRep = LocalDB.instance.getAudioTales();
  getTalesListRepository() {
    TalesList talesListRep = _talesListRep;
    return talesListRep;
  }
}
