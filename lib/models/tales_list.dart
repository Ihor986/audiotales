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
        .where((element) => element.pathUrl != '')
        .map((e) => e.size)
        .fold(0, (num previousValue, element) => previousValue + element);
    // i.fold(0, (num previousValue, element) => previousValue + element);
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
}
