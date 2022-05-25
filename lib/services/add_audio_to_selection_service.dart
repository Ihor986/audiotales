import '../data_base/data_base.dart';
import '../models/selections.dart';
import '../models/tales_list.dart';
import '../utils/consts/texts_consts.dart';

class AddAudioToSelectionService {
  AddAudioToSelectionService();
  String name = TextsConst.addNewSelectionsTextName;
  List<String> checkedList = [];

  void checkEvent(bool isChecked, String id) {
    if (isChecked) {
      checkedList.remove(id);
    } else {
      checkedList.add(id);
    }
  }

  void saveCreatedSelectionEvent(
      {required TalesList talesList, required SelectionsList selectionsList}) {
    String _selectionId = DateTime.now().millisecondsSinceEpoch.toString();
    String _name = name;
    Selection selection = Selection(id: _selectionId, name: _name);
    TalesList _talesList = talesList;
    SelectionsList _selectionsList = selectionsList;

    _selectionsList.addNewSelection(selection);

    for (String id in checkedList) {
      _talesList.fullTalesList.map(
        (element) {
          if (element.id == id) {
            element.compilationsId.add(_selectionId);
          }
          return element;
        },
      ).toList();
    }

    DataBase.instance.saveAudioTales(_talesList);
    DataBase.instance.saveSelectionsList(_selectionsList);
    dispouse();
  }

  void dispouse() {
    checkedList = [];
    name = TextsConst.addNewSelectionsTextName;
  }
}
