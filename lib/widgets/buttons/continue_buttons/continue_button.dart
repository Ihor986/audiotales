import 'package:flutter/material.dart';
import '../../../pages/new_user/registration_phone.dart';
import '../../../utils/consts/colors.dart';

class ContinueButtonNewUser extends StatelessWidget {
  const ContinueButtonNewUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final AuthBlockBloc authBloc = context.read<AuthBlockBloc>();
    // num screenWidth = MediaQuery.of(context).size.width;
    // num screenHeight = MediaQuery.of(context).size.height;
    return Center(
      child: Column(
        children: [
          // SizedBox(
          //   height: screenHeight * 0.5,
          // ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true)
                  .pushNamedAndRemoveUntil(
                RegistrationPage.routeName,
                (_) => false,
              );
            },
            child: Text(
              continueButtonText,
              style: const TextStyle(fontSize: 18),
            ),
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(309, 59),
                primary: rose,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
          ),
        ],
      ),
    );
  }
}

String continueButtonText = 'Продолжить';
