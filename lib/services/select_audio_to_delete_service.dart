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

  deleteSelectedAudioEvent({
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
            DataBase.instance.deleteAudioTaleFromDB(id, _talesList);
          }
          return element;
        },
      ).toList();
    }
    DataBase.instance.saveAudioTales(_talesList);
    dispouse();
  }

  deleteOldAudio({
    required TalesList talesList,
  }) {
    // int today = DateTime.now().millisecondsSinceEpoch.toInt();
    // int howMenyDays = 86400000 * 15;
    // TalesList _talesList = talesList;
    // _talesList.fullTalesList.map(
    //   (element) {
    //     if (element.deletedDate == null) {
    //       return element;
    //     }
    //     if (int.parse(element.deletedDate ?? '0') < today - howMenyDays) {
    //       DataBase.instance.deleteAudioTaleFromDB(element.id, _talesList);
    //     }
    //     return element;
    //   },
    // ).toList();
    // DataBase.instance.saveAudioTales(_talesList);
    // dispouse();
  }

  restoreSelectedAudioEvent({
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
