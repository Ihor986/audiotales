import 'package:flutter/material.dart';

import '../../utils/consts/colors.dart';

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
        child: Center(
          child: Text(
            hello,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        height: screenHeight / 15,
        width: screenWidth * 0.7,
        decoration: BoxDecoration(
          color: white,
          boxShadow: [
            BoxShadow(
              color: boxShadow,
              offset: const Offset(0, 5),
              blurRadius: 6,
            ),
          ],
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      SizedBox(
        height: screenHeight / 14,
      ),
      Icon(
        Icons.favorite,
        color: rose,
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
        children: [
          Text(
            textHello1,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          Text(
            textHello2,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
      height: screenHeight / 13,
      width: screenWidth * 0.7,
      decoration: BoxDecoration(
        color: white,
        boxShadow: [
          BoxShadow(
            color: boxShadow,
            offset: const Offset(0, 5),
            blurRadius: 6,
          ),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}

String hello = 'Мы рады тебя видеть';
String textHello1 = 'Взрослые иногда нуждаются в';
String textHello2 = 'сказке даже больше, чем дети';
