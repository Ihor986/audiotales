import 'package:audiotales/utils/consts/custom_colors.dart';
import 'package:flutter/material.dart';

import '../../../../utils/consts/texts_consts.dart';

class ProfileText extends StatelessWidget {
  const ProfileText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Column(
      children: [
        Text(
          TextsConst.profile,
          style: TextStyle(
              color: CustomColors.white,
              fontWeight: FontWeight.bold,
              fontSize: screen.width * 0.07),
        ),
        Text(
          TextsConst.profileTextPeace,
          style: TextStyle(
              color: CustomColors.white, fontSize: screen.width * 0.03),
        )
      ],
    );
  }
}

class EditeText extends StatelessWidget {
  const EditeText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // num screenHeight = MediaQuery.of(context).size.height;
    return const Text(TextsConst.profileTextEdite,
        style: TextStyle(color: CustomColors.black));
  }
}

class SaveText extends StatelessWidget {
  const SaveText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // num screenHeight = MediaQuery.of(context).size.height;
    return const Text(TextsConst.save,
        style: TextStyle(color: CustomColors.black));
  }
}

class SubscribeText extends StatelessWidget {
  const SubscribeText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // num screenHeight = MediaQuery.of(context).size.height;
    return const Text(
      TextsConst.profileTextSubscribe,
      style: TextStyle(
          decoration: TextDecoration.underline, color: CustomColors.black),
    );
  }
}

class LogoutText extends StatelessWidget {
  const LogoutText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // num screenHeight = MediaQuery.of(context).size.height;
    return const Text(TextsConst.profileTextLogout,
        style: TextStyle(color: CustomColors.black));
  }
}

class DeleteAccountText extends StatelessWidget {
  const DeleteAccountText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // num screenHeight = MediaQuery.of(context).size.height;
    return const Text(TextsConst.profileTextDeleteAccount,
        style: TextStyle(color: CustomColors.red));
  }
}
