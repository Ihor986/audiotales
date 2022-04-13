import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_bloc/auth_block_bloc.dart';
import '../../utils/consts/colors.dart';
import '../../widgets/buttons/continue_buttons/continue_button_code.dart';
import '../../widgets/buttons/continue_buttons/continue_button_phone.dart';
import '../../widgets/inputs/registration_code_input.dart';
import '../../widgets/inputs/registration_phone_input.dart';
import '../../widgets/texts/registration_text.dart';
import '../../widgets/uncategorized/custom_clipper_widget.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key? key}) : super(key: key);
  static const routeName = '/new_user/registration_phone.dart';

  @override
  Widget build(BuildContext context) {
    // num screenWidth = MediaQuery.of(context).size.width;
    num screenHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<AuthBlockBloc, AuthBlockState>(
        builder: (context, state) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: blueSoso,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Column(
              children: [
                ClipPath(
                  clipper: OvalBC(),
                  child: Container(
                    height: screenHeight / 4.5,
                    color: blueSoso,
                    child: const RegistrationText(),
                  ),
                ),
                state is AuthBlockInitial
                    ? const ContinuePhone()
                    : const ContinueCode(),
                state is AuthBlockInitial
                    ? const ContinueButtonPhone()
                    : const ContinueButtonCode(),
              ],
            ),
            // state is AuthBlockInitial
            //     ? const ContinueButtonPhone()
            //     : const ContinueButtonCode(),
          ],
        ),
      );
    });
  }
}

class ContinuePhone extends StatelessWidget {
  const ContinuePhone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    num screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: screenHeight / 20,
        ),
        const RegistrationText1(),
        SizedBox(
          height: screenHeight / 50,
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
    num screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: screenHeight / 40,
        ),
        const RegistrationText3(),
        SizedBox(
          height: screenHeight / 50,
        ),
        const RegistrationCodeInput(),
      ],
    );
  }
}
