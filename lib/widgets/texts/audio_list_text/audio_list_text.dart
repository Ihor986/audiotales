import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/audio.dart';
import '../../../repositorys/tales_list_repository.dart';
import '../../../utils/consts/texts_consts.dart';

class AudioListText extends StatelessWidget {
  const AudioListText({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    final List<AudioTale> talesList =
        RepositoryProvider.of<TalesListRepository>(context)
            .getActiveTalesList();

    num time = talesList[index].time.round();

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

    return Text(
      '$time $text',
      style: const TextStyle(
        color: Colors.black,
        fontStyle: FontStyle.normal,
        fontSize: 14,
      ),
    );
  }
}
