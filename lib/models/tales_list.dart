import 'package:cloud_firestore/cloud_firestore.dart';

import 'audio.dart';

class TalesList {
  TalesList({required this.fullTalesList});

  final List<AudioTale> fullTalesList;

  List<AudioTale> getCompilation(String value) {
    return fullTalesList
        .where((element) =>
            element.compilationsId.contains(value) &&
            element.isDeleted == false)
        .toList();
  }

  num getCompilationTime(value) {
    return fullTalesList
        .where((element) =>
            element.compilationsId.contains(value) &&
            element.isDeleted == false)
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
    fullTalesList.add(audioTale);
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
      list1.add(e.id);
    }
    List<AudioTale> list = newTalesList.fullTalesList
        .where((e) => list1.contains(e.id) ? false : true)
        .toList();
    fullTalesList.addAll(list);
  }
}
