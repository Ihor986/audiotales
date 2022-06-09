import 'package:flutter/material.dart';

import '../../../../utils/consts/custom_colors.dart';
import '../../../../utils/consts/texts_consts.dart';

class DeletedScreenTitleText extends StatelessWidget {
  const DeletedScreenTitleText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Column(
      children: [
        Text(
          TextsConst.deletedTitleFirst,
          style: TextStyle(
              color: CustomColors.white,
              fontWeight: FontWeight.bold,
              fontSize: screen.width * 0.07),
        ),
        Text(
          TextsConst.deletedTitleSecond,
          style: TextStyle(
              color: CustomColors.white,
              fontWeight: FontWeight.bold,
              fontSize: screen.width * 0.07),
        ),
      ],
    );
  }
}

class DeletedCanselText extends StatelessWidget {
  const DeletedCanselText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Text(
      TextsConst.deletedTitleSecond,
      style: TextStyle(
          color: CustomColors.white,
          fontWeight: FontWeight.bold,
          fontSize: screen.width * 0.07),
    );
  }
}

class DeletedDateText extends StatelessWidget {
  const DeletedDateText({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Text(
      text,
      style: TextStyle(
          color: CustomColors.noTalesText,
          // fontWeight: FontWeight.bold,
          fontSize: screen.width * 0.035),
    );
  }
}
