import 'package:cloud_firestore/cloud_firestore.dart';

import 'audio.dart';

class TalesList {
  TalesList({required this.fullTalesList});

  final List<AudioTale> fullTalesList;

  getCompilation(String value) {
    return fullTalesList
        .where((element) => element.compilationsId.contains(value));
  }

  getTalesListSize() {
    return fullTalesList
        .where((element) => element.pathUrl != null)
        .map((e) => e.size)
        .fold(0, (num previousValue, element) => previousValue + element);
  }

  addNewAudio(AudioTale audioTale) {
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
    List<AudioTale> tList = listJson.map((e) => AudioTale.fromJson(e)).toList();
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
    var list1 = [];
    for (var e in fullTalesList) {
      list1.add(e.id);
    }
    var list = newTalesList.fullTalesList
        .where((e) => list1.contains(e.id) ? false : true);
    fullTalesList.addAll(list);

    print('$fullTalesList ??????');
  }
}
