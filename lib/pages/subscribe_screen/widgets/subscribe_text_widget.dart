import 'package:flutter/material.dart';

import '../../../utils/consts/custom_colors.dart';
import '../../../utils/consts/texts_consts.dart';

class SubscribeScreenTitleText extends StatelessWidget {
  const SubscribeScreenTitleText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Column(
      children: [
        Text(
          TextsConst.subscribe,
          style: TextStyle(
              color: CustomColors.white,
              fontWeight: FontWeight.bold,
              fontSize: screen.width * 0.07),
        ),
        Text(
          TextsConst.subscribe2,
          style: TextStyle(
              color: CustomColors.white, fontSize: screen.width * 0.03),
        )
      ],
    );
  }
}
