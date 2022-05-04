import 'audio.dart';

class TalesList {
  TalesList({required this.talesList});

  final List<AudioTale> talesList;

  getCompilation(String value) {
    return talesList.where((element) => element.compilationsId.contains(value));
  }

  addNewAudio(AudioTale audioTale) {
    talesList.add(audioTale);
  }

  Map<String, dynamic> toJson() => {
        'talesList': talesList.map((e) => e.toJson()).toList(),
      };

  factory TalesList.fromJson(Map<String, dynamic> json) {
    List listJson = json['talesList'];
    List<AudioTale> tList = listJson.map((e) => AudioTale.fromJson(e)).toList();

    return TalesList(
      talesList: tList,
    );
  }

  // get getList {
  //   List<AudioTale> talesList = _talesList;
  //   return talesList;
  // }
}
