import 'package:audiotales/utils/consts/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/selections.dart';
import '../../../models/tales_list.dart';
import '../../../repositorys/tales_list_repository.dart';
import '../../../utils/consts/texts_consts.dart';

class SelectionsText extends StatelessWidget {
  const SelectionsText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Column(
      children: [
        Text(
          TextsConst.collections,
          style: TextStyle(
              color: CustomColors.white,
              fontWeight: FontWeight.bold,
              fontSize: screen.width * 0.09),
        ),
        Text(
          TextsConst.selectionsTextAllInOnePlace,
          style: TextStyle(
              color: CustomColors.white, fontSize: screen.width * 0.035),
        )
      ],
    );
  }
}

class WrapSelectionsListTextName extends StatelessWidget {
  WrapSelectionsListTextName({Key? key, required this.selection})
      : super(key: key);
  Selection selection;
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

class WrapSelectionsListTextData extends StatelessWidget {
  WrapSelectionsListTextData({Key? key, required this.selection})
      : super(key: key);
  Selection selection;
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
        _talesList.getCompilation(selection.id).length.toString() +
            TextsConst.selectionAudioText;

    String textTime = _selectionFullTime + TextsConst.selectionAudioLengthText;

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
