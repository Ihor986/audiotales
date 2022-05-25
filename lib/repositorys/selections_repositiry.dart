import 'package:audiotales/data_base/data_base.dart';
import '../models/selections.dart';

class SelectionsListRepository {
  SelectionsList getSelectionsListRepository() {
    SelectionsList selectionsListRep = DataBase.instance.getSelectionsList();
    return selectionsListRep;
  }
}
