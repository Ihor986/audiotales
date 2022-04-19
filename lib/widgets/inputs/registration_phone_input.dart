import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../bloc/auth_bloc/auth_block_bloc.dart';
import '../../utils/consts/custom_colors.dart';

class RegistrationPhoneInput extends StatefulWidget {
  const RegistrationPhoneInput({Key? key}) : super(key: key);

  @override
  State<RegistrationPhoneInput> createState() => _RegistrationPhoneInputState();
}

class _RegistrationPhoneInputState extends State<RegistrationPhoneInput> {
  final maskFormatter = MaskTextInputFormatter(
      mask: '+38 (0##) ### ## ##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  @override
  Widget build(BuildContext context) {
    final AuthBlockBloc authBloc = context.read<AuthBlockBloc>();
    return Container(
        decoration: BoxDecoration(
          color: CustomColors.white,
          boxShadow: const [
            BoxShadow(
              color: CustomColors.boxShadow,
              offset: Offset(0, 5),
              blurRadius: 6,
            ),
          ],
          borderRadius: BorderRadius.circular(41),
        ),
        width: 309,
        height: 59,
        child: TextFormField(
          // autofocus: true,
          onChanged: (value) {
            authBloc.authReposytory.phoneNumberForVerification =
                '+380${maskFormatter.getUnmaskedText()}';
          },
          textAlign: TextAlign.center,
          // autofillHints: const <String>[AutofillHints.telephoneNumber],
          // style: const TextStyle(
          //   letterSpacing: 2,
          // ),
          cursorRadius: const Radius.circular(41.0),
          keyboardType: TextInputType.phone,
          inputFormatters: [
            maskFormatter,
          ],
          decoration: const InputDecoration(
            // contentPadding: EdgeInsets.symmetric(horizontal: 70, vertical: 20),
            hintText: '+38(0XX)XXX XX XX',
            hintStyle: TextStyle(color: Colors.black),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(41.0)),
                borderSide: BorderSide(
                    color: Color.fromRGBO(246, 246, 246, 1), width: 2.0)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(41.0)),
                borderSide: BorderSide(
                    color: Color.fromRGBO(246, 246, 246, 1), width: 2.0)),
          ),
        ));
  }
}
