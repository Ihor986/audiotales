import 'package:audiotales/utils/consts/custom_colors.dart';
import 'package:flutter/material.dart';

import '../../../../models/selections.dart';
import '../../../../services/minuts_text_convert_service.dart';

class TitleSelectionScreen extends StatelessWidget {
  const TitleSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('');
  }
}

class DateSelectionScreen extends StatelessWidget {
  const DateSelectionScreen({
    Key? key,
    required this.selection,
  }) : super(key: key);

  final Selection selection;

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    String text = TimeTextConvertService.instance.dayMonthYear(selection.date);
    return Text(
      text,
      style: TextStyle(
          color: CustomColors.white,
          fontSize: screen.height * 0.01,
          fontWeight: FontWeight.bold),
    );
  }
}
