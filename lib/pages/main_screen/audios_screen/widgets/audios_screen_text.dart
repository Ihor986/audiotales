import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/tales_list.dart';
import '../../../../repositorys/tales_list_repository.dart';
import '../../../../services/minuts_text_convert_service.dart';
import '../../../../utils/consts/custom_colors.dart';
import '../../../../utils/consts/texts_consts.dart';

class AudiosScreenText extends StatelessWidget {
  const AudiosScreenText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Column(
      children: [
        Text(
          TextsConst.audiofiles,
          style: TextStyle(
              color: CustomColors.white,
              fontWeight: FontWeight.bold,
              fontSize: screen.width * 0.07),
        ),
        Text(
          TextsConst.selectionsTextAllInOnePlace,
          style: TextStyle(
              color: CustomColors.white, fontSize: screen.width * 0.03),
        )
      ],
    );
  }
}

class AudiosScreenListTextData extends StatelessWidget {
  const AudiosScreenListTextData({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    final TalesList _talesList =
        RepositoryProvider.of<TalesListRepository>(context)
            .getTalesListRepository();
    num _millisecondsListTime = _talesList.getActiveTalesFullTime() * 60000;
    String _selectionFullTime = DateTime.fromMillisecondsSinceEpoch(
            _millisecondsListTime.toInt(),
            isUtc: true)
        .toString()
        .substring(11, 16);

    String textAudio = _talesList.getActiveTalesList().length.toString() +
        TextsConst.selectionAudioText;

    String textTime = _selectionFullTime +
        TimeTextConvertService.instance.getConvertedHouresText(
            timeInHoures: _millisecondsListTime / 3600000);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            textAudio,
            style: TextStyle(
              color: CustomColors.white,
              fontSize: screen.height * 0.015,
            ),
          ),
        ),
        Flexible(
          child: Text(
            textTime,
            style: TextStyle(
              color: CustomColors.white,
              fontSize: screen.height * 0.015,
            ),
          ),
        ),
      ],
    );
  }
}

class AudioScreenPlayAllTextT extends StatelessWidget {
  const AudioScreenPlayAllTextT({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // num screenHeight = MediaQuery.of(context).size.height;
    return const Text(TextsConst.audioScreenPlayAllT,
        style: TextStyle(color: CustomColors.blueSoso));
  }
}

class AudioScreenPlayAllTextF extends StatelessWidget {
  const AudioScreenPlayAllTextF({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // num screenHeight = MediaQuery.of(context).size.height;
    return const Text(TextsConst.audioScreenPlayAllF,
        style: TextStyle(color: CustomColors.blueSoso));
  }
}
