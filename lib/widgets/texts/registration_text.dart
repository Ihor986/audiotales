import 'package:audiotales/utils/consts/texts_consts.dart';
import 'package:flutter/material.dart';

import '../../utils/consts/custom_colors.dart';

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
        children: const [
          Text(
            TextsConst.textHello1,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          Text(
            TextsConst.textHello2,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          Text(
            TextsConst.textHello3,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
      height: screenHeight * 0.1,
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
        const Text(
          TextsConst.later,
          style: TextStyle(
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
      TextsConst.registration,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontStyle: FontStyle.normal,
        fontSize: 48,
      ),
    );
Text registration1() => const Text(
      TextsConst.enterPhoneNumber,
      style: TextStyle(
        // fontWeight: FontWeight.bold,
        color: CustomColors.black,
        fontStyle: FontStyle.normal,
        fontSize: 16,
      ),
    );
Text registration2() => const Text(
      TextsConst.enterTheCodeFromTheSMS,
      style: TextStyle(
        // fontWeight: FontWeight.bold,
        color: CustomColors.black,
        fontStyle: FontStyle.normal,
        fontSize: 16,
      ),
    );
Text registration3() => const Text(
      TextsConst.enterTheCodeFromTheSMS2,
      style: TextStyle(
        // fontWeight: FontWeight.bold,
        color: CustomColors.black,
        fontStyle: FontStyle.normal,
        fontSize: 16,
      ),
    );
