import 'package:audiotales/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data_base/data_base.dart';
import '../../../../repositorys/auth.dart';
import '../../../../repositorys/user_reposytory.dart';
import '../../../../utils/consts/custom_colors.dart';
import '../../../../utils/consts/texts_consts.dart';
import '../../../main_screen/main_screen.dart';

class ContinueButtonCode extends StatelessWidget {
  const ContinueButtonCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LocalUser _user =
        RepositoryProvider.of<UserRepository>(context).getLocalUser();
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
              authReposytory.sendCodeToFirebase(context);
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
                DataBase.instance.saveUser(_user);
                Navigator.of(context, rootNavigator: true)
                    .pushNamedAndRemoveUntil(
                  MainScreen.routeName,
                  (_) => false,
                );
              },
              child: const _RegistrationText4()),
          const _RegistrationText2(),
        ],
      ),
    );
  }
}

class _RegistrationText2 extends StatelessWidget {
  const _RegistrationText2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    num screenWidth = MediaQuery.of(context).size.width;
    num screenHeight = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            TextsConst.textHello1,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          Text(
            TextsConst.textHello2,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          Text(
            TextsConst.textHello3,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
      height: screenHeight * 0.1,
      width: screenWidth * 0.7,
      decoration: BoxDecoration(
        color: CustomColors.white,
        boxShadow: const [
          BoxShadow(
            color: CustomColors.boxShadow,
            offset: Offset(0, 5),
            blurRadius: 6,
          ),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}

class _RegistrationText4 extends StatelessWidget {
  const _RegistrationText4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    num screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          TextsConst.later,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        SizedBox(height: screenHeight / 40),
      ],
    );
  }
}
