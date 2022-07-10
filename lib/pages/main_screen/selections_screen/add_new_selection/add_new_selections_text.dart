import 'package:audiotales/utils/custom_colors.dart';
import 'package:flutter/material.dart';

import '../../../../utils/texts_consts.dart';
import 'select_audio/select_audio_screen.dart';

class AddNewSelectionsText extends StatelessWidget {
  const AddNewSelectionsText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Column(
      children: [
        Text(
          TextsConst.addNewSelectionsTextCreate,
          style: TextStyle(
              color: CustomColors.white,
              fontWeight: FontWeight.bold,
              fontSize: screen.width * 0.09),
        ),
      ],
    );
  }
}

class AddNewSelectionsTextReady extends StatelessWidget {
  const AddNewSelectionsTextReady({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Align(
      alignment: const Alignment(0, 0.7),
      child: Text(
        TextsConst.addNewSelectionsTextReady,
        style:
            TextStyle(color: CustomColors.white, fontSize: screen.width * 0.03),
      ),
    );
  }
}

class AddNewSelectionsTextAddAudio extends StatelessWidget {
  const AddNewSelectionsTextAddAudio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, SelectAudioScreen.routeName);
      },
      child: Text(
        TextsConst.addNewSelectionsTextAddAudio,
        style: TextStyle(
          color: CustomColors.black,
          fontSize: screen.width * 0.033,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
