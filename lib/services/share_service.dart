import 'dart:io';

import 'package:audiotales/models/audio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../data_base/data/local_data_base.dart';

class ShareAudioService {
  ShareAudioService._();
  static final ShareAudioService instance = ShareAudioService._();
  final Share shareService = Share();
  final List<String> paths = [];
  final List<String> downloadsPaths = [];
  String? text;

  Future<void> shareFiles({
    required List<AudioTale> talesList,
    List<String>? idList,
  }) async {
    if (idList == null) {
      for (var item in talesList) {
        final String? _path = await _saveAudioToDevice(audio: item);
        if (_path != null) {
          downloadsPaths.add(_path);
        }
      }
      for (var item in talesList) {
        if (item.path != null) {
          paths.add(item.path!);
        }
      }
      paths.addAll(downloadsPaths);
      await _onShareWithResult();
    }
    if (idList != null) {
      for (var item in talesList) {
        if (idList.contains(item.id)) {
          final String? _path = await _saveAudioToDevice(audio: item);
          if (_path != null) {
            downloadsPaths.add(_path);
          }
        }
      }
      for (var item in talesList) {
        if (idList.contains(item.id)) {
          if (item.path != null) {
            paths.add(item.path!);
          }
        }
      }
      paths.addAll(downloadsPaths);
      await _onShareWithResult();
    }
  }

  Future<String?> _saveAudioToDevice({
    required AudioTale audio,
  }) async {
    if (audio.pathUrl == null || audio.path != null) return null;
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('${LocalDB.instance.getUser().id}/audio/')
        .child(audio.id);
    final Directory dir = await getApplicationDocumentsDirectory();
    final File file = File('${dir.path}/${audio.id}');
    await storageRef.writeToFile(file);
    return file.path;
  }

  Future<void> _onShareWithResult() async {
    // ShareResult result;
    if (paths.isEmpty) return;
    // result =
    await Share.shareFilesWithResult(
      paths,
      text: text,
    );
    // print(result.status.toString());
    _deleteDownloadFiles();
  }

  void _deleteDownloadFiles() {
    if (downloadsPaths.isEmpty) return;
    for (var item in downloadsPaths) {
      File(item).delete();
      print('deleted');
    }
  }

  void dispouse() {
    paths.clear();
    downloadsPaths.clear();
    text = null;
  }
}
