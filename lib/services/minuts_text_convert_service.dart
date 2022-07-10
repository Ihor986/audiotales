import '../utils/texts_consts.dart';

enum Period {
  year,
  month,
}

class TimeTextConvertService {
  const TimeTextConvertService._();

  static const TimeTextConvertService instance = TimeTextConvertService._();
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
    if ('$time'.substring('$time'.length - 1).contains('2') ||
        '$time'.substring('$time'.length - 1).contains('3') ||
        '$time'.substring('$time'.length - 1).contains('4')) {
      text = TextsConst.selectionAudioLengthText;
    } else {
      text = TextsConst.selectionAudioLengthText2;
    }
    return text;
  }

  String dayMonthYear(String value) {
    int idToInt = int.parse(value);
    DateTime fullDate = DateTime.fromMillisecondsSinceEpoch(idToInt);
    String d = '0${fullDate.day}'.substring('0${fullDate.day}'.length - 2);
    String m = '0${fullDate.month}'.substring('0${fullDate.month}'.length - 2);
    String y = '0${fullDate.year}'.substring('0${fullDate.year}'.length - 2);
    String result = '$d.$m.$y';
    return result;
  }

  String dayMonthYearSubscribe({
    required Period period,
  }) {
    int m = DateTime.now().month;
    int y = DateTime.now().year;
    int dm;
    int dy;
    List m30 = [4, 6, 9, 11];
    if (y % 4 == 0 && y % 100 == 0 && y % 4 == 0) {
      dy = 366;
    } else {
      dy = 365;
    }
    if (m == 2) {
      dy == 365 ? dm = 28 : dm = 29;
    } else if (m30.contains(m)) {
      dm = 30;
    } else {
      dm = 31;
    }

    if (period == Period.year) {
      return DateTime.now().add(Duration(days: dy)).toString();
    } else {
      return DateTime.now().add(Duration(days: dm)).toString();
    }
  }
}
