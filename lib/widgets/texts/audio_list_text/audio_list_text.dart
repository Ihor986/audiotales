import 'package:flutter/material.dart';
import '../../../services/minuts_text_convert_service.dart';

class AudioListText extends StatelessWidget {
  const AudioListText({Key? key, required this.time}) : super(key: key);
  final num time;
  @override
  Widget build(BuildContext context) {
    String text = TimeTextConvertService.instance
        .getConvertedMinutesText(timeInMinutes: time);

    return Text(
      '${time.round()} $text',
      style: const TextStyle(
        color: Colors.black,
        fontStyle: FontStyle.normal,
        fontSize: 14,
      ),
    );
  }
}
