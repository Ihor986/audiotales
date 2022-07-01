import 'dart:io';

import 'package:audiotales/data_base/data_base.dart';
import 'package:audiotales/models/audio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

import '../data_base/data/local_data_base.dart';
import '../models/tales_list.dart';

class DownloadAudioService {
  DownloadAudioService._();
  static final DownloadAudioService instance = DownloadAudioService._();
  // final List<String> paths = [];
  // final List<String> downloadsPaths = [];
  // String? text;

  Future<void> downloadAudioToDevice({
    required List<String> audioList,
    required TalesList talesList,
  }) async {
    for (var id in audioList) {
      AudioTale? audio = talesList.getAudio(id);
      if (audio == null) continue;
      if (audio.pathUrl == null || audio.path != null) continue;
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('${LocalDB.instance.getUser().id}/audio/')
          .child(audio.id);
      final Directory dir = await getApplicationDocumentsDirectory();
      final File file = File('${dir.path}/${audio.id}');
      await storageRef.writeToFile(file);
      talesList.changeAudioPath(id: audio.id, path: file.path);
    }
    await DataBase.instance.saveAudioTales(talesList);
  }

  void dispouse() {
    // paths.clear();
    // downloadsPaths.clear();
    // text = null;
  }
}
