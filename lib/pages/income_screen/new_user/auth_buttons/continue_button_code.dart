import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/auth_bloc/auth_block_bloc.dart';
import '../../../../data_base/local_data_base.dart';
import '../../../../repositorys/auth.dart';
import '../../../../utils/consts/custom_colors.dart';
import '../../../../utils/consts/texts_consts.dart';
import '../../../../widgets/texts/registration_text.dart';
import '../../../main_screen/main_screen.dart';

class ContinueButtonCode extends StatelessWidget {
  const ContinueButtonCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthBlockBloc authBloc = context.read<AuthBlockBloc>();
    final AuthReposytory authReposytory =
        RepositoryProvider.of<AuthReposytory>(context);
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
              authReposytory.sendCodeToFirebase(context);
              // print(authBloc.authReposytory.verificationCode);
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
          TextButton(
              onPressed: () {
                LocalDB.instance.saveUser(authBloc.user);
                Navigator.of(context, rootNavigator: true)
                    .pushNamedAndRemoveUntil(
                  MainScreen.routeName,
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
