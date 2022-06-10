import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/tales_list.dart';
import '../../../pages/main_screen/main_screen_block/main_screen_bloc.dart';
import '../../../utils/consts/custom_colors.dart';
import '../../../utils/consts/texts_consts.dart';

class RemoveToDeletedConfirm {
  const RemoveToDeletedConfirm._();

  static const RemoveToDeletedConfirm instance = RemoveToDeletedConfirm._();

  deletedConfirm({
    required Size screen,
    required BuildContext context,
    required String id,
    required TalesList talesList,
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
                id: id,
                talesList: talesList,
              ),
              const _ConfirmButtonNo(),
            ],
            title: const _DeleteCohfirmText(),
            insetPadding: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            content: SizedBox(
              height: screen.height * 0.07,
              child: const _DeleteWarningText(),
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
      TextsConst.deleteConfirm,
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
          TextsConst.remuveForDelete1,
          style: TextStyle(
            color: CustomColors.deleteWarningTextColor,
          ),
        ),
        Text(
          TextsConst.remuveForDelete2,
          style: TextStyle(
            color: CustomColors.deleteWarningTextColor,
          ),
        ),
        Text(
          TextsConst.remuveForDelete3,
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
  // final String id;
  // final TalesList talesList;

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
  const _ConfirmButtonYes({Key? key, required this.id, required this.talesList})
      : super(key: key);
  final String id;
  final TalesList talesList;

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    final MainScreenBloc _mainScreenBloc =
        BlocProvider.of<MainScreenBloc>(context);
    return GestureDetector(
      onTap: () {
        _mainScreenBloc
            .add(RemoveToDeleteAudioEvent(id: id, talesList: talesList));
        print('object');
        Navigator.pop(context);
      },
      child: Container(
        width: screen.width * 0.2,
        height: screen.height * 0.05,
        decoration: BoxDecoration(
          border: Border.all(color: CustomColors.blueSoso),
          color: CustomColors.blueSoso,
          borderRadius: const BorderRadius.all(const Radius.circular(51)),
        ),
        child: const Center(
            child: Text(
          'Yes',
          style: TextStyle(color: CustomColors.white),
        )),
      ),
    );
  }
}
