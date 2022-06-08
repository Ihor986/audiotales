import 'package:audiotales/utils/consts/custom_colors.dart';
import 'package:audiotales/utils/consts/texts_consts.dart';
import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Column(
      children: [
        Text(
          TextsConst.audioTales,
          style: TextStyle(
            fontSize: screen.height * 0.029,
            color: CustomColors.black,
          ),
        ),
        SizedBox(
          height: screen.height * 0.07,
        ),
        Text(
          TextsConst.menu,
          style: TextStyle(
            fontSize: screen.height * 0.025,
            color: CustomColors.noTalesText,
          ),
        ),
      ],
    );
  }
}

class BodyText extends StatelessWidget {
  const BodyText({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left: screen.height * 0.02),
      child: Text(
        text,
        style: TextStyle(
          fontSize: screen.height * 0.02,
          color: CustomColors.black,
        ),
      ),
    );
  }
}

class DuobleBodyText extends StatelessWidget {
  const DuobleBodyText({
    Key? key,
    required this.text,
    required this.textTwo,
  }) : super(key: key);
  final String text;
  final String textTwo;
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left: screen.height * 0.02),
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: screen.height * 0.02,
              color: CustomColors.black,
            ),
          ),
          Text(
            textTwo,
            style: TextStyle(
              fontSize: screen.height * 0.02,
              color: CustomColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
