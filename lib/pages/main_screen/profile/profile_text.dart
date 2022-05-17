import 'package:audiotales/utils/consts/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositorys/user_reposytory.dart';
import '../../../utils/consts/texts_consts.dart';

class ProfileText extends StatelessWidget {
  const ProfileText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // num screenHeight = MediaQuery.of(context).size.height;
    return const Text(TextsConst.profile);
  }
}

class NameText extends StatelessWidget {
  const NameText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserRepository _user = RepositoryProvider.of<UserRepository>(context);
    // num screenHeight = MediaQuery.of(context).size.height;
    return _user.localUser.name == null
        ? const Text(TextsConst.profileTextName,
            style: TextStyle(color: CustomColors.black))
        : Text(_user.localUser.name!,
            style: const TextStyle(color: CustomColors.black));
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
