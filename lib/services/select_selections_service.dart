import 'package:audiotales/models/audio.dart';

import '../data_base/data_base.dart';
import '../models/tales_list.dart';

class SelectSelectionsService {
  AudioTale? audio;
  List<String>? audioList;
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

  Future<void> addSelections({
    required TalesList fullTalesList,
  }) async {
    if (audio != null) {
      _addSelectionsToAudio(fullTalesList: fullTalesList);
    }
    if (audioList != null) {
      _addSelectionsToAudios(fullTalesList: fullTalesList);
    }
  }

  Future<void> _addSelectionsToAudio({
    required TalesList fullTalesList,
  }) async {
    // print(audio);
    if (audio == null) return;
    // if (audio!.isEmpty) return;
    final TalesList _talesList = fullTalesList;
    final String _id = audio!.id;
    _talesList.changeAudioSelectionsId(
      id: _id,
      selectionsId: selectionsIdList,
    );
    print(_talesList.fullTalesList
        .firstWhere((element) => element.id == _id)
        .compilationsId);
    await DataBase.instance.saveAudioTales(_talesList);
    dispose();
  }

  Future<void> _addSelectionsToAudios({
    required TalesList fullTalesList,
  }) async {
    if (audioList!.isEmpty) return;
    final TalesList _talesList = fullTalesList;
    for (var item in audioList!) {
      _talesList.addNewAudioSelectionsId(
        id: item,
        selectionsId: selectionsIdList,
      );
      print(_talesList.fullTalesList
          .firstWhere((element) => element.id == item)
          .compilationsId);
    }
    await DataBase.instance.saveAudioTales(_talesList);
    dispose();
  }

  dispose() {
    audio = null;
    readOnly = true;
    selectionsIdList.clear();
  }
}
