import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../bloc/navigation_bloc/navigation_bloc.dart';
import '../../sound_bloc/sound_bloc.dart';
import 'cancel_record_button_text.dart';

class CancelRecordButton extends StatelessWidget {
  const CancelRecordButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SoundBloc _soundBloc = BlocProvider.of<SoundBloc>(context);
    final NavigationBloc _navdBloc = BlocProvider.of<NavigationBloc>(context);
    return TextButton(
        onPressed: () {
          _soundBloc.add(StopRecordEvent());
          _navdBloc.add(ChangeCurrentIndexEvent(currentIndex: 0));
        },
        child: const CancelRecordButtonText());
  }
}
