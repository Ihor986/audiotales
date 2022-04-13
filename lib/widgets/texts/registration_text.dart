import 'package:flutter/material.dart';

import '../../utils/consts/colors.dart';

class RegistrationText extends StatelessWidget {
  const RegistrationText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: registration());
  }
}

class RegistrationText1 extends StatelessWidget {
  const RegistrationText1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: registration1());
  }
}

class RegistrationText2 extends StatelessWidget {
  const RegistrationText2({Key? key}) : super(key: key);

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
          Text(
            textHello3,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
      height: screenHeight * 0.1,
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

class RegistrationText3 extends StatelessWidget {
  const RegistrationText3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: registration2()),
        Center(child: registration3()),
      ],
    );
  }
}

class RegistrationText4 extends StatelessWidget {
  const RegistrationText4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    num screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // SizedBox(height: screenHeight / 40),
        Text(
          later,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        SizedBox(height: screenHeight / 40),
      ],
    );
  }
}

Text registration() => const Text(
      'Регистрация',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontStyle: FontStyle.normal,
        fontSize: 48,
      ),
    );
Text registration1() => Text(
      'Введи номер телефона',
      style: TextStyle(
        // fontWeight: FontWeight.bold,
        color: black,
        fontStyle: FontStyle.normal,
        fontSize: 16,
      ),
    );
Text registration2() => Text(
      'Введи код из смс, чтобы мы ',
      style: TextStyle(
        // fontWeight: FontWeight.bold,
        color: black,
        fontStyle: FontStyle.normal,
        fontSize: 16,
      ),
    );
Text registration3() => Text(
      'тебя запомнили',
      style: TextStyle(
        // fontWeight: FontWeight.bold,
        color: black,
        fontStyle: FontStyle.normal,
        fontSize: 16,
      ),
    );
String textHello1 = 'Регистрация привяжет твои сказки ';
String textHello2 = 'к облаку, после чего они всегда ';
String textHello3 = 'будут с тобой';
String later = 'Позже';
