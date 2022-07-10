import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/custom_colors.dart';
import '../../../utils/texts_consts.dart';
import '../../../widgets/uncategorized/custom_clipper_widget.dart';
import '../auth_bloc/auth_block_bloc.dart';
import 'auth_buttons/continue_button_code.dart';
import 'auth_buttons/continue_button_phone.dart';
import 'registratuin_widgets/registration_code_input.dart';
import 'registratuin_widgets/registration_phone_input.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key? key}) : super(key: key);
  static const routeName = '/new_user/registration_phone.dart';

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return BlocBuilder<AuthBlockBloc, AuthBlockState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColors.blueSoso,
          elevation: 0,
        ),
        body: GestureDetector(
          onTap: () {
            if (FocusNode().hasFocus) {
              FocusScope.of(context).unfocus();
            } else {
              FocusScope.of(context).requestFocus(FocusNode());
            }
          },
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            reverse: true,
            child: Column(
              children: [
                ClipPath(
                  clipper: OvalBC(),
                  child: Container(
                    height: screen.height / 4.5,
                    color: CustomColors.blueSoso,
                    child: const _RegistrationText(),
                  ),
                ),
                state.status == Status.phone
                    ? const ContinuePhone()
                    : const ContinueCode(),
                state.status == Status.phone
                    ? const ContinueButtonPhone()
                    : const ContinueButtonCode(),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class ContinuePhone extends StatelessWidget {
  const ContinuePhone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          // height: double.infinity / 20,
          height: screen.height / 20,
        ),
        const _RegistrationText1(),
        SizedBox(
          height: screen.height / 50,
        ),
        const RegistrationPhoneInput(),
      ],
    );
  }
}

class ContinueCode extends StatelessWidget {
  const ContinueCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: screen.height / 40,
        ),
        const _RegistrationText3(),
        SizedBox(
          height: screen.height / 50,
        ),
        const RegistrationCodeInput(),
      ],
    );
  }
}

class _RegistrationText extends StatelessWidget {
  const _RegistrationText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        TextsConst.registration,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontStyle: FontStyle.normal,
          fontSize: 48,
        ),
      ),
    );
  }
}

class _RegistrationText1 extends StatelessWidget {
  const _RegistrationText1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      TextsConst.enterPhoneNumber,
      style: TextStyle(
        color: CustomColors.black,
        fontStyle: FontStyle.normal,
        fontSize: 16,
      ),
    ));
  }
}

class _RegistrationText3 extends StatelessWidget {
  const _RegistrationText3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Center(
          child: Text(
            TextsConst.enterTheCodeFromTheSMS,
            style: TextStyle(
              color: CustomColors.black,
              fontStyle: FontStyle.normal,
              fontSize: 16,
            ),
          ),
        ),
        Center(
            child: Text(
          TextsConst.enterTheCodeFromTheSMS2,
          style: TextStyle(
            color: CustomColors.black,
            fontStyle: FontStyle.normal,
            fontSize: 16,
          ),
        )),
      ],
    );
  }
}
