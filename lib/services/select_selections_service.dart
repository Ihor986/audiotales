import 'package:audiotales/models/audio.dart';

import '../data_base/data_base.dart';
import '../models/tales_list.dart';

class SelectSelectionsService {
  AudioTale? audio;
  bool readOnly = true;
  final List selectionsIdList = [];

  void changeIDList(String id) {
    bool isContain = selectionsIdList.contains(id);
    if (isContain) {
      selectionsIdList.remove(id);
    } else {
      selectionsIdList.add(id);
    }
  }

  Future<void> addSelectionsToAudio({
    required TalesList fullTalesList,
  }) async {
    print(audio);
    if (audio == null) {
      return;
    }
    final TalesList _talesList = fullTalesList;
    final String _id = audio!.id;
    _talesList.updateAudioSelectionsId(
      id: _id,
      selectionsId: selectionsIdList,
    );
    print(_talesList.fullTalesList
        .firstWhere((element) => element.id == _id)
        .compilationsId);
    await DataBase.instance.saveAudioTales(_talesList);
    dispose();
  }

  dispose() {
    audio = null;
    readOnly = true;
    selectionsIdList.clear();
  }
}
