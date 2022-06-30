import 'package:flutter/material.dart';

import '../../utils/consts/custom_colors.dart';

class PlayerWidget extends StatelessWidget {
  const PlayerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColors.white,
        border: Border.all(color: CustomColors.audioBorder),
        borderRadius: const BorderRadius.all(Radius.circular(41)),
      ),
    );
  }
}
