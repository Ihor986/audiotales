import 'package:audiotales/utils/consts/texts_consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/auth_bloc/auth_block_bloc.dart';
import '../../../pages/main_screen/main_screen.dart';
import '../../../utils/consts/custom_colors.dart';
import '../../texts/registration_text.dart';

class ContinueButtonPhone extends StatelessWidget {
  const ContinueButtonPhone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthBlockBloc authBloc = context.read<AuthBlockBloc>();
    // num screenWidth = MediaQuery.of(context).size.width;
    num screenHeight = MediaQuery.of(context).size.height;
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.05,
          ),
          ElevatedButton(
            onPressed: () {
              authBloc.authReposytory.verifyPhoneNumber();
              authBloc.add(ContinueButtonPhoneEvent());
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
          SizedBox(height: screenHeight / 40),
          TextButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamedAndRemoveUntil(
                  MainScreen.routeName,
                  (_) => false,
                );
              },
              child: const RegistrationText4()),
          SizedBox(
            height: screenHeight * 0.05,
          ),
          const RegistrationText2(),
        ],
      ),
    );
  }
}
