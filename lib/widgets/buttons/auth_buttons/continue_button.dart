import 'package:audiotales/utils/consts/texts_consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/auth_bloc/auth_block_bloc.dart';
import '../../../data_base/local_data_base.dart';
import '../../../pages/new_user/registration_phone.dart';
import '../../../utils/consts/custom_colors.dart';

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
              // print(authBloc.user.toJson());
              LocalDB.instance.saveUser(authBloc.user);
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