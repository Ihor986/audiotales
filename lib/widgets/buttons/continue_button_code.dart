import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/auth_bloc/auth_block_bloc.dart';
import '../../pages/test.dart';
import '../../utils/consts/colors.dart';
import '../texts/registration_text.dart';

class ContinueButtonCode extends StatelessWidget {
  const ContinueButtonCode({Key? key}) : super(key: key);

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
              authBloc.authReposytory.sendCodeToFirebase(context);
              print(authBloc.authReposytory.verificationCode);
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
          TextButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamedAndRemoveUntil(
                  Test.routeName,
                  (_) => false,
                );
              },
              child: const RegistrationText4()),
          const RegistrationText2(),
        ],
      ),
    );
  }
}

String continueButtonText = 'Продолжить';
