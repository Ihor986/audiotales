import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../bloc/navigation_bloc/navigation_bloc.dart';
import '../../../../../utils/texts_consts.dart';
import '../../record_bloc/record_bloc.dart';

class CancelRecordButton extends StatelessWidget {
  const CancelRecordButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RecordBloc _soundBloc = BlocProvider.of<RecordBloc>(context);
    final NavigationBloc _navdBloc = BlocProvider.of<NavigationBloc>(context);
    return TextButton(
        onPressed: () async {
          await _soundBloc.sound.stopRecorder();
          _navdBloc.add(ChangeCurrentIndexEvent(currentIndex: 0));
        },
        child: const _CancelRecordButtonText());
  }
}

class _CancelRecordButtonText extends StatelessWidget {
  const _CancelRecordButtonText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      TextsConst.cancel,
      style: TextStyle(
        color: Colors.black,
        fontStyle: FontStyle.normal,
        fontSize: 14,
      ),
    );
  }
}
