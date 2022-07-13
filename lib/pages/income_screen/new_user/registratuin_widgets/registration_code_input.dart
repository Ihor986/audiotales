import 'package:audiotales/repositories/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../utils/custom_colors.dart';

class RegistrationCodeInput extends StatefulWidget {
  const RegistrationCodeInput({Key? key}) : super(key: key);

  @override
  State<RegistrationCodeInput> createState() => _RegistrationCodeInputState();
}

class _RegistrationCodeInputState extends State<RegistrationCodeInput> {
  final maskFormatter = MaskTextInputFormatter(
      mask: '######',
      filter: {'#': RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  @override
  Widget build(BuildContext context) {
    final AuthReposytory authReposytory =
        RepositoryProvider.of<AuthReposytory>(context);
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
          autofocus: false,
          onChanged: (value) {
            authReposytory.smsCode = maskFormatter.getUnmaskedText();
          },
          textAlign: TextAlign.center,
          // style: const TextStyle(
          //   letterSpacing: 10,
          // ),
          cursorRadius: const Radius.circular(41.0),
          keyboardType: TextInputType.number,
          inputFormatters: [
            maskFormatter,
          ],
          decoration: const InputDecoration(
            // contentPadding: EdgeInsets.symmetric(horizontal: 120, vertical: 20),
            hintText: 'XXXXXX',
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
