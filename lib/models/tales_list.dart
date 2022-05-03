import 'audio.dart';

class TalesList {
  TalesList(this._talesList);

  final List<AudioTale> _talesList;

  getCompilation(String value) {
    return _talesList
        .where((element) => element.compilationsId.contains(value));
  }

  addNewAudio(AudioTale audioTale) {
    _talesList.add(audioTale);
  }

  Map<String, dynamic> toJson() => {
        'talesList': _talesList,
      };

  // factory TalesList.fromJson(Map<String, dynamic> json) {
  //   return TalesList(
  //     json['talesList'].split(""),
  //   );
  // }

  get getList {
    List<AudioTale> talesList = _talesList;
    return talesList;
  }
}
