import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/audio.dart';
import '../../../repositorys/tales_list_repository.dart';
import '../../../services/helpers/minuts_text_convert_helper.dart';

class AudioListText extends StatelessWidget {
  const AudioListText({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    final List<AudioTale> talesList =
        RepositoryProvider.of<TalesListRepository>(context)
            .getActiveTalesList();

    num time = talesList[index].time;

    String text = MinutesTextConvertHelper.instance
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
