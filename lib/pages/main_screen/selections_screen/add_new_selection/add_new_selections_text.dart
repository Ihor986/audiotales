import 'package:audiotales/utils/consts/custom_colors.dart';
import 'package:flutter/material.dart';

import '../../../../utils/consts/texts_consts.dart';
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

class AddNewSelectionsTextName extends StatelessWidget {
  const AddNewSelectionsTextName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Text(
      TextsConst.addNewSelectionsTextName,
      style:
          TextStyle(color: CustomColors.white, fontSize: screen.width * 0.055),
    );
  }
}

class AddNewSelectionsTextDescription extends StatelessWidget {
  const AddNewSelectionsTextDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Text(
      TextsConst.addNewSelectionsTextEnterDescription,
      style:
          TextStyle(color: CustomColors.black, fontSize: screen.width * 0.033),
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
        Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
          SelectAudioScreen.routeName,
          (_) => true,
        );
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
