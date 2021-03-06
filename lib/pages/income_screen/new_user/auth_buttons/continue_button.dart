import 'package:audiotales/utils/texts_consts.dart';
import 'package:flutter/material.dart';

import '../../../../utils/custom_colors.dart';
import '../registration_page.dart';

class ContinueButtonNewUser extends StatelessWidget {
  const ContinueButtonNewUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              // print(authBloc.user.toJson());
              // LocalDB.instance.saveUser(authBloc.user);
              Navigator.of(context, rootNavigator: true)
                  .pushNamedAndRemoveUntil(
                RegistrationPage.routeName,
                (_) => false,
              );
            },
            child: const Text(
              TextsConst.continueButtonText,
              style: TextStyle(fontSize: 18),
            ),
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(309, 59),
                primary: CustomColors.rose,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
          ),
        ],
      ),
    );
  }
}
