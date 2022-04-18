import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/auth_bloc/auth_block_bloc.dart';
import '../../../data_base/local_data_base.dart';
import '../../../pages/new_user/registration_phone.dart';
import '../../../utils/consts/colors.dart';

class ContinueButtonNewUser extends StatelessWidget {
  const ContinueButtonNewUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthBlockBloc authBloc = context.read<AuthBlockBloc>();
    return Center(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              LocalDB.instance.saveUser(authBloc.user);
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
