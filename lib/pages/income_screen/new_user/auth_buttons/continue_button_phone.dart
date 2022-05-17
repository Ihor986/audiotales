import 'package:audiotales/utils/consts/texts_consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data_base/data_base.dart';
import '../../../../models/user.dart';
import '../../../../repositorys/auth.dart';
import '../../../../repositorys/user_reposytory.dart';
import '../../../../utils/consts/custom_colors.dart';
import '../../../../widgets/texts/registration_text.dart';
import '../../../main_screen/main_screen.dart';
import '../../auth_bloc/auth_block_bloc.dart';

class ContinueButtonPhone extends StatelessWidget {
  const ContinueButtonPhone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthBlockBloc authBloc = context.read<AuthBlockBloc>();
    final LocalUser _user =
        RepositoryProvider.of<UserRepository>(context).localUser;
    final AuthReposytory authReposytory =
        RepositoryProvider.of<AuthReposytory>(context);
    Size screen = MediaQuery.of(context).size;
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: screen.height * 0.05,
          ),
          ElevatedButton(
            onPressed: () {
              if (authReposytory.phoneNumberForVerification.length == 13) {
                authReposytory.verifyPhoneNumber();
                authBloc.add(ContinueButtonPhoneEvent());
              }
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
          SizedBox(height: screen.height / 40),
          TextButton(
              onPressed: () {
                DataBase.instance.saveUser(_user);
                Navigator.of(context, rootNavigator: true)
                    .pushNamedAndRemoveUntil(
                  MainScreen.routeName,
                  (_) => false,
                );
              },
              child: const RegistrationText4()),
          SizedBox(
            height: screen.height * 0.05,
          ),
          const RegistrationText2(),
        ],
      ),
    );
  }
}
