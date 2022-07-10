import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/navigation_bloc/navigation_bloc.dart';
import '../../../pages/main_screen/main_screen_block/main_screen_bloc.dart';

import '../../../utils/custom_colors.dart';
import '../../../utils/texts_consts.dart';

class DeleteUnsavedConfirm {
  const DeleteUnsavedConfirm._();

  static const DeleteUnsavedConfirm instance = DeleteUnsavedConfirm._();

  void deletedConfirm({
    required Size screen,
    required BuildContext context,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            actionsPadding: EdgeInsets.only(bottom: screen.height * 0.03),
            actionsAlignment: MainAxisAlignment.center,
            actions: const [
              _ConfirmButtonYes(),
              _ConfirmButtonNo(),
            ],
            title: const _DeleteConfirmText(),
            insetPadding: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
          );
        });
      },
    );
  }
}

class _DeleteConfirmText extends StatelessWidget {
  const _DeleteConfirmText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      TextsConst.deleteConfirm,
      style: TextStyle(color: CustomColors.red),
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
  const _ConfirmButtonYes({
    Key? key,

    // required this.talesList,
  }) : super(key: key);

  // final TalesList talesList;

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    final MainScreenBloc _mainScreenBloc =
        BlocProvider.of<MainScreenBloc>(context);
    final NavigationBloc _navdBloc = BlocProvider.of<NavigationBloc>(context);
    return GestureDetector(
      onTap: () {
        _mainScreenBloc.add(DeleteUnsavedAudioEvent());
        _navdBloc.add(ChangeCurrentIndexEvent(currentIndex: 0));
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
          'Yes',
          style: TextStyle(color: CustomColors.white),
        )),
      ),
    );
  }
}
