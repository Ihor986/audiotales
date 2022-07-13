import 'package:audiotales/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/selection.dart';
import '../../../../models/tales_list.dart';
import '../../../../repositories/tales_list_repository.dart';
import '../../../../services/minuts_text_convert_service.dart';
import '../../../../utils/texts_consts.dart';

class SelectionsText extends StatelessWidget {
  const SelectionsText({
    Key? key,
    required this.readOnly,
  }) : super(key: key);
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Column(
      children: [
        Text(
          TextsConst.collections,
          style: TextStyle(
              color: readOnly ? CustomColors.white : CustomColors.whiteOp05,
              fontWeight: FontWeight.bold,
              fontSize: screen.width * 0.07),
        ),
        Text(
          TextsConst.selectionsTextAllInOnePlace,
          style: TextStyle(
              color: readOnly ? CustomColors.white : CustomColors.whiteOp05,
              fontSize: screen.width * 0.03),
        )
      ],
    );
  }
}

class WrapSelectionsListTextName extends StatelessWidget {
  const WrapSelectionsListTextName({Key? key, required this.selection})
      : super(key: key);
  final Selection selection;
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Flexible(
      child: Text(
        selection.name,
        style: TextStyle(
          color: CustomColors.white,
          fontWeight: FontWeight.bold,
          fontSize: screen.width * 0.03,
        ),
      ),
    );
  }
}

class SelectSelectionTextAdd extends StatelessWidget {
  const SelectSelectionTextAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Align(
      alignment: const Alignment(0, 0.7),
      child: Text(
        TextsConst.selectAudioTextAdd,
        style:
            TextStyle(color: CustomColors.white, fontSize: screen.width * 0.03),
      ),
    );
  }
}

class WrapSelectionsListTextData extends StatelessWidget {
  const WrapSelectionsListTextData({Key? key, required this.selection})
      : super(key: key);
  final Selection selection;
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    final TalesList _talesList =
        RepositoryProvider.of<TalesListRepository>(context)
            .getTalesListRepository();
    num _millisecondsCompilationTime =
        _talesList.getCompilationTime(selection.id) * 60000;
    String _selectionFullTime = DateTime.fromMillisecondsSinceEpoch(
            _millisecondsCompilationTime.toInt(),
            isUtc: true)
        .toString()
        .substring(12, 16);

    String textAudio =
        _talesList.getCompilation(id: selection.id).length.toString() +
            TextsConst.selectionAudioText;

    String textTime = _selectionFullTime +
        TimeTextConvertService.instance.getConvertedHouresText(
            timeInHoures: _millisecondsCompilationTime / 3600000);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            textAudio,
            style: TextStyle(
              color: CustomColors.white,
              fontSize: screen.width * 0.025,
            ),
          ),
        ),
        Flexible(
          child: Text(
            textTime,
            style: TextStyle(
              color: CustomColors.white,
              fontSize: screen.width * 0.025,
            ),
          ),
        ),
      ],
    );
  }
}
