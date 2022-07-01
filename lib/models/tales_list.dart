import 'package:audiotales/models/selections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'audio.dart';

class TalesList {
  TalesList({required this.fullTalesList});

  final List<AudioTale> fullTalesList;

  List<AudioTale> getActiveTalesList() {
    final bool auth = FirebaseAuth.instance.currentUser != null;
    if (auth) {
      List<AudioTale> activeTalesListRep = fullTalesList.where((element) {
        bool isPath = element.path != null || element.pathUrl != null;
        bool isNotDeleted = !element.isDeleted;
        return isPath && isNotDeleted;
      }).toList();
      return activeTalesListRep;
    } else {
      List<AudioTale> activeTalesListRep = fullTalesList.where((element) {
        bool isPath = element.path != null;
        bool isNotDeleted = !element.isDeleted;
        return isPath && isNotDeleted;
      }).toList();
      return activeTalesListRep;
    }
  }

  List<AudioTale> getDelitedTalesList() {
    final bool auth = FirebaseAuth.instance.currentUser != null;
    List<AudioTale> delitedTalesListRep;
    if (auth) {
      delitedTalesListRep =
          fullTalesList.where((element) => element.isDeleted).toList();
      delitedTalesListRep
          .sort((a, b) => a.deletedDate!.compareTo(b.deletedDate!));
    } else {
      delitedTalesListRep = fullTalesList
          .where((element) => element.isDeleted && element.path != null)
          .toList();
      delitedTalesListRep
          .sort((a, b) => a.deletedDate!.compareTo(b.deletedDate!));
    }
    return delitedTalesListRep.reversed.toList();
  }

  List<AudioTale> getCompilation(String value) {
    return fullTalesList
        .where((element) =>
            element.compilationsId.contains(value) &&
            element.isDeleted == false)
        .toList();
  }

  AudioTale? getAudio(String id) {
    List<AudioTale> list =
        fullTalesList.where((element) => element.id == id).toList();

    return list.isNotEmpty ? list.first : null;
  }

  num getCompilationTime(String value) {
    return fullTalesList
        .where((element) =>
            element.compilationsId.contains(value) &&
            element.isDeleted == false)
        .map((e) => e.time)
        .fold(0, (num previousValue, element) => previousValue + element);
  }

  num getActiveTalesFullTime() {
    return fullTalesList
        .where((element) => element.isDeleted == false)
        .map((e) => e.time)
        .fold(0, (num previousValue, element) => previousValue + element);
  }

  num getTalesListSize() {
    return fullTalesList
        .where((element) => element.pathUrl != null)
        .map((e) => e.size)
        .fold(0, (num previousValue, element) => previousValue + element);
  }

  void addNewAudio(AudioTale audioTale) {
    fullTalesList.insert(0, audioTale);
  }

  void deleteSelectionFromAudio(Selection selection) {
    var l = fullTalesList
        .where((element) => element.compilationsId.contains(selection.id))
        .toList();
    for (var item in l) {
      item.compilationsId.remove(selection.id);
    }
  }

  Map<String, dynamic> toJson() => {
        'talesList': fullTalesList.map((e) => e.toJson()).toList(),
      };

  factory TalesList.fromJson(Map<String, dynamic> json) {
    List listJson = json['talesList'];
    List<AudioTale> tList = listJson.map((e) => AudioTale.fromJson(e)).toList();

    return TalesList(
      fullTalesList: tList,
    );
  }

  // TalesList.fromFirestore(
  //   DocumentSnapshot<Map<String, dynamic>> snapshot,
  //   SnapshotOptions? options,
  // ) : fullTalesList = snapshot.data()?['talesList'];

  factory TalesList.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    List listJson = snapshot.data()?['talesList'];
    List<AudioTale> tList =
        listJson.map((e) => AudioTale.fromFirestore(e)).toList();
    return TalesList(
      fullTalesList: tList,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'talesList': fullTalesList.map((e) => e.toFirestore()).toList(),
    };
  }

  void updateTalesList({required TalesList newTalesList}) {
    List<String> list1 = [];
    for (var e in fullTalesList) {
      final int oldUpdate = int.parse(e.updateDate ?? '0');
      final AudioTale newAudio = newTalesList.fullTalesList
          .firstWhere((element) => element.id == e.id, orElse: () => e);
      final int newUpdate = int.parse(newAudio.updateDate ?? '0');
      if (newUpdate > oldUpdate) {
        e.updateFromFB(newAudio);
      }

      list1.add(e.id);
    }
    List<AudioTale> list = newTalesList.fullTalesList
        .where((e) => list1.contains(e.id) ? false : true)
        .toList();
    fullTalesList.addAll(list);
  }

  void removeAudioToDeleted({
    required List<String> idList,
  }) {
    for (var id in idList) {
      _removeAudioToDeleted(
        id: id,
      );
    }
  }

  void _removeAudioToDeleted({
    required String id,
  }) {
    for (var audio in fullTalesList) {
      if (audio.id == id) {
        audio.updateAudio(nIsDeleted: true);
      }
    }
  }

  void changeAudioPath({
    required String id,
    required String path,
  }) {
    for (var audio in fullTalesList) {
      if (audio.id == id) {
        audio.updateAudio(nPath: path);
      }
    }
  }

  void changeAudioName({
    required String id,
    required String name,
  }) {
    for (var audio in fullTalesList) {
      if (audio.id == id) {
        audio.updateAudio(nName: name);
      }
    }
  }

  void changeAudioSelectionsId({
    required String id,
    required List selectionsId,
  }) {
    for (var audio in fullTalesList) {
      if (audio.id == id) {
        audio.updateAudio(nCompilationsId: selectionsId);
      }
    }
  }

  void addNewAudioSelectionsId({
    required String id,
    required List selectionsId,
  }) {
    for (var audio in fullTalesList) {
      if (audio.id == id) {
        audio.updateAudio(addCompilationsId: selectionsId);
      }
    }
  }

  void deleteAudio({
    required String id,
  }) {
    if (id == '') return;
    fullTalesList.removeWhere((element) => element.id == id);
  }
}
