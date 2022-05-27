import '../utils/consts/texts_consts.dart';

class MinutesTextConvertService {
  const MinutesTextConvertService._();

  static const MinutesTextConvertService instance =
      MinutesTextConvertService._();
  String getConvertedMinutesText({required num timeInMinutes}) {
    num time = timeInMinutes.round();

    String text = '';
    if (time > 4 && time < 21) {
      text = TextsConst.minutes;
    } else if ('$time'.substring('$time'.length - 1).contains('1')) {
      text = TextsConst.minutes1;
    } else if ('$time'.substring('$time'.length - 1).contains('2') ||
        '$time'.substring('$time'.length - 1).contains('3') ||
        '$time'.substring('$time'.length - 1).contains('4')) {
      text = TextsConst.minutes2;
    } else {
      text = TextsConst.minutes;
    }
    return text;
  }

  String getConvertedHouresText({required num timeInHoures}) {
    num time = timeInHoures.round();

    String text = '';
    // if (time > 4 && time < 21) {
    //   text = TextsConst.selectionAudioLengthText2;
    // } else if ('$time'.substring('$time'.length - 1).contains('1')) {
    //   text = TextsConst.selectionAudioLengthText2;
    // } else
    if ('$time'.substring('$time'.length - 1).contains('2') ||
        '$time'.substring('$time'.length - 1).contains('3') ||
        '$time'.substring('$time'.length - 1).contains('4')) {
      text = TextsConst.selectionAudioLengthText;
    } else {
      text = TextsConst.selectionAudioLengthText2;
    }
    return text;
  }
}
