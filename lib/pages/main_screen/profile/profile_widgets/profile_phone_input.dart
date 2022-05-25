import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../../models/user.dart';
import '../../../../repositorys/auth.dart';
import '../../../../repositorys/user_reposytory.dart';
import '../../../../utils/consts/custom_colors.dart';

class ProfilePhoneInput extends StatefulWidget {
  const ProfilePhoneInput({Key? key}) : super(key: key);

  @override
  State<ProfilePhoneInput> createState() => _ProfilePhoneInputState();
}

class _ProfilePhoneInputState extends State<ProfilePhoneInput> {
  final maskFormatter = MaskTextInputFormatter(
      initialText: '+38(0',
      mask: '+38 (###) ### ## ##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  @override
  Widget build(BuildContext context) {
    final LocalUser _user =
        RepositoryProvider.of<UserRepository>(context).getLocalUser();
    // final AuthBlockBloc authBloc = context.read<AuthBlockBloc>();
    final AuthReposytory authReposytory =
        RepositoryProvider.of<AuthReposytory>(context);
    //  getUser(UserRepository _user) async {
    //   final user = await _user.localUser;
    //   return user;
    // }

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
          initialValue: maskFormatter
              .maskText(_user.phone ?? '0000000000000'.substring(3)),
          readOnly: true,
          autofocus: true,
          onChanged: (value) {
            authReposytory.phoneNumberForVerification =
                '+380${maskFormatter.getUnmaskedText()}';
          },
          textAlign: TextAlign.center,
          cursorRadius: const Radius.circular(41.0),
          keyboardType: TextInputType.phone,
          inputFormatters: [
            maskFormatter,
          ],
          decoration: const InputDecoration(
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
