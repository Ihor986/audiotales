import 'package:audiotales/models/audio.dart';
import 'package:audiotales/pages/main_screen/record_screen/sound_bloc/sound_bloc.dart';

import '../data_base/data_base.dart';
import '../data_base/data_base.dart';
import '../models/tales_list.dart';

class ChangeAudioServise {
  String? name;

  saveChangedAudioName({
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

  dispose() {
    name = null;
  }
}
