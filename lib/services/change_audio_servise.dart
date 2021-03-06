import 'package:audiotales/models/tale.dart';

import '../data_base/data_base.dart';
import '../models/tales_list.dart';

class ChangeAudioServise {
  ChangeAudioServise._();

  static final ChangeAudioServise instance = ChangeAudioServise._();
  String? name;

  Future<void> saveChangedAudioName({
    required AudioTale audio,
    required TalesList fullTalesList,
  }) async {
    final TalesList _talesList = fullTalesList;
    final String _id = audio.id;
    final String _name = name ?? audio.name;
    _talesList.changeAudioName(id: _id, name: _name);
    await DataBase.instance.saveAudioTales(_talesList);
    dispose();
  }

  void dispose() {
    name = null;
  }
}
