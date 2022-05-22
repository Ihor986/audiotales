import 'package:audiotales/utils/consts/custom_colors.dart';
import 'package:flutter/material.dart';

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
              color: CustomColors.white,
              // fontWeight: FontWeight.bold,
              fontSize: screen.width * 0.035),
        )
      ],
    );
  }
}
