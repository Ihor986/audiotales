import '../../utils/consts/texts_consts.dart';

class MinutesTextConvertHelper {
  const MinutesTextConvertHelper._();

  static const MinutesTextConvertHelper instance = MinutesTextConvertHelper._();
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

  //   String getConvertedHouresText({required num timeInMinutes}) {
  //   num time = timeInMinutes.round();

  //   String text = '';
  //   if (time > 4 && time < 21) {
  //     text = TextsConst.minutes;
  //   } else if ('$time'.substring('$time'.length - 1).contains('1')) {
  //     text = TextsConst.minutes1;
  //   } else if ('$time'.substring('$time'.length - 1).contains('2') ||
  //       '$time'.substring('$time'.length - 1).contains('3') ||
  //       '$time'.substring('$time'.length - 1).contains('4')) {
  //     text = TextsConst.minutes2;
  //   } else {
  //     text = TextsConst.minutes;
  //   }
  //   return text;
  // }
}
