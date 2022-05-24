import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/consts/custom_colors.dart';
import '../auth_bloc/auth_block_bloc.dart';
import 'registration_code_input.dart';
import 'registration_phone_input.dart';
import '../../../widgets/texts/registration_text.dart';
import '../../../widgets/uncategorized/custom_clipper_widget.dart';
import 'auth_buttons/continue_button_code.dart';
import 'auth_buttons/continue_button_phone.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key? key}) : super(key: key);
  static const routeName = '/new_user/registration_phone.dart';

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return BlocBuilder<AuthBlockBloc, AuthBlockState>(
        builder: (context, state) {
      return Scaffold(
        // resizeToAvoidBottomInset: false,
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
                    child: const RegistrationText(),
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
        const RegistrationText1(),
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
        const RegistrationText3(),
        SizedBox(
          height: screen.height / 50,
        ),
        const RegistrationCodeInput(),
      ],
    );
  }
}
