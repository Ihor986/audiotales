import 'package:flutter/material.dart';

import '../../utils/consts/custom_colors.dart';
import '../../utils/consts/texts_consts.dart';

class StartRegularUserText1 extends StatelessWidget {
  const StartRegularUserText1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    num screenWidth = MediaQuery.of(context).size.width;
    num screenHeight = MediaQuery.of(context).size.height;

    return Column(children: [
      SizedBox(
        height: screenHeight / 15,
      ),
      Container(
        child: const Center(
          child: Text(
            TextsConst.hello,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        height: screenHeight / 15,
        width: screenWidth * 0.7,
        decoration: BoxDecoration(
          color: CustomColors.white,
          boxShadow: const [
            BoxShadow(
              color: CustomColors.boxShadow,
              offset: Offset(0, 5),
              blurRadius: 6,
            ),
          ],
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      SizedBox(
        height: screenHeight / 14,
      ),
      const Icon(
        Icons.favorite,
        color: CustomColors.rose,
        size: 45,
      ),
      SizedBox(
        height: screenHeight / 14,
      ),
    ]);
  }
}

class StartRegularUserText2 extends StatelessWidget {
  const StartRegularUserText2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    num screenWidth = MediaQuery.of(context).size.width;
    num screenHeight = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            TextsConst.textHello11,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          Text(
            TextsConst.textHello12,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
      height: screenHeight / 13,
      width: screenWidth * 0.7,
      decoration: BoxDecoration(
        color: CustomColors.white,
        boxShadow: const [
          BoxShadow(
            color: CustomColors.boxShadow,
            offset: Offset(0, 5),
            blurRadius: 6,
          ),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
