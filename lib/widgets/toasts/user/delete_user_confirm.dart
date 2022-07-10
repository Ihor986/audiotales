import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/navigation_bloc/navigation_bloc.dart';
import '../../../data_base/data_base.dart';
import '../../../utils/custom_colors.dart';
import '../../../utils/texts_consts.dart';

class DeleteUserConfirm {
  const DeleteUserConfirm._();

  static const DeleteUserConfirm instance = DeleteUserConfirm._();

  void deletedConfirm({
    required Size screen,
    required BuildContext context,
    bool? isClosePage,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            actionsPadding: EdgeInsets.only(bottom: screen.height * 0.03),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              _ConfirmButtonYes(
                isClosePage: isClosePage,
              ),
              const _ConfirmButtonNo(),
            ],
            title: const _DeleteCohfirmText(),
            insetPadding: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            content: const SizedBox(
              height: 80,
              child: _DeleteWarningText(),
            ),
          );
        });
      },
    );
  }
}

class _DeleteCohfirmText extends StatelessWidget {
  const _DeleteCohfirmText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      TextsConst.deleteAccountConfirm,
      style: TextStyle(color: CustomColors.red),
    );
  }
}

class _DeleteWarningText extends StatelessWidget {
  const _DeleteWarningText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          TextsConst.remuveForUserDelete1,
          style: TextStyle(
            color: CustomColors.deleteWarningTextColor,
          ),
        ),
        Text(
          TextsConst.remuveForUserDelete2,
          style: TextStyle(
            color: CustomColors.deleteWarningTextColor,
          ),
        ),
        Text(
          TextsConst.remuveForUserDelete3,
          style: TextStyle(
            color: CustomColors.deleteWarningTextColor,
          ),
        ),
      ],
    );
  }
}

class _ConfirmButtonNo extends StatelessWidget {
  const _ConfirmButtonNo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: screen.width * 0.2,
        height: screen.height * 0.05,
        decoration: BoxDecoration(
          border: Border.all(color: CustomColors.blueSoso),
          color: CustomColors.white,
          borderRadius: const BorderRadius.all(Radius.circular(51)),
        ),
        child: const Center(
            child: Text(
          'No',
          style: TextStyle(color: CustomColors.blueSoso),
        )),
      ),
    );
  }
}

class _ConfirmButtonYes extends StatelessWidget {
  const _ConfirmButtonYes({
    Key? key,
    this.isClosePage,
  }) : super(key: key);

  final bool? isClosePage;
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () async {
        await DataBase.instance.deleteUser();
        context.read<NavigationBloc>().add(
              ChangeCurrentIndexEvent(currentIndex: 0),
            );
        Navigator.pop(context);
      },
      child: Container(
        width: screen.width * 0.2,
        height: screen.height * 0.05,
        decoration: BoxDecoration(
          border: Border.all(color: CustomColors.blueSoso),
          color: CustomColors.blueSoso,
          borderRadius: const BorderRadius.all(Radius.circular(51)),
        ),
        child: const Center(
            child: Text(
          TextsConst.deleteAccount,
          style: TextStyle(color: CustomColors.white),
        )),
      ),
    );
  }
}
