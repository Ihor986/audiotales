import 'package:flutter/material.dart';

import '../../../../../utils/consts/custom_colors.dart';
import '../../../../../utils/consts/texts_consts.dart';

class SelectAudioText extends StatelessWidget {
  const SelectAudioText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Column(
      children: [
        Text(
          TextsConst.selectAudioText,
          style: TextStyle(
              color: CustomColors.white,
              fontWeight: FontWeight.bold,
              fontSize: screen.width * 0.09),
        ),
      ],
    );
  }
}

class SelectAudioTextAdd extends StatelessWidget {
  const SelectAudioTextAdd({Key? key}) : super(key: key);

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
