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
      print(audio?.name);
      await _addSelectionsToAudio(fullTalesList: fullTalesList);
    }
    if (audioList != null) {
      await _addSelectionsToAudios(fullTalesList: fullTalesList);
      print('audioList!.');
    }
  }

  Future<void> _addSelectionsToAudio({
    required TalesList fullTalesList,
  }) async {
    if (audio == null) return;
    final String _id = audio!.id;
    fullTalesList.changeAudioSelectionsId(
      id: _id,
      selectionsId: selectionsIdList,
    );

    await DataBase.instance.saveAudioTales(fullTalesList);
    dispose();
  }

  Future<void> _addSelectionsToAudios({
    required TalesList fullTalesList,
  }) async {
    if (audioList!.isEmpty) return;
    for (var item in audioList!) {
      fullTalesList.addNewAudioSelectionsId(
        id: item,
        selectionsId: selectionsIdList,
      );
    }
    await DataBase.instance.saveAudioTales(fullTalesList);
    dispose();
  }

  dispose() {
    audio = null;
    readOnly = true;
    selectionsIdList.clear();
  }
}
