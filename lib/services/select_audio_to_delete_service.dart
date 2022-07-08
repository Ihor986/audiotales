import '../data_base/data_base.dart';
import '../models/tales_list.dart';

class SelectAudioToDeleteService {
  SelectAudioToDeleteService();
  final List<String> checkedList = [];
  bool isChosen = false;

  void checkEvent(bool isChecked, String id) {
    if (isChecked) {
      checkedList.remove(id);
    } else {
      checkedList.add(id);
    }
  }

  Future<void> deleteSelectedAudioEvent({
    required TalesList talesList,
  }) async {
    TalesList _talesList = talesList;
    bool isAllDelete = checkedList.isEmpty && isChosen == false;
    if (isAllDelete) {
      checkedList.addAll(_talesList.getDelitedTalesList().map((e) => e.id));
    }
    if (checkedList.isEmpty) return;
    await DataBase.instance.deleteAudioTaleFromDB(checkedList, _talesList);
    // for (String id in checkedList) {
    //   _talesList.fullTalesList.removeWhere((element) => element.id == id);
    // }
    // DataBase.instance.saveAudioTales(_talesList);
    dispouse();
  }

  void restoreSelectedAudioEvent({
    required TalesList talesList,
  }) {
    TalesList _talesList = talesList;
    bool isAllDelete = checkedList.isEmpty && isChosen == false;
    if (isAllDelete) {
      checkedList.addAll(_talesList.getDelitedTalesList().map((e) => e.id));
    }
    for (String id in checkedList) {
      _talesList.fullTalesList.map(
        (element) {
          if (element.id == id) {
            element.isDeleted = false;
            element.deletedDate = null;
          }
          return element;
        },
      ).toList();
    }
    DataBase.instance.saveAudioTales(_talesList);
    dispouse();
  }

  void dispouse() {
    checkedList.clear();
    isChosen = false;
  }
}
