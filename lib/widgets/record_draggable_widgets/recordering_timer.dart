import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/navigation_bloc/navigation_bloc.dart';
import '../../bloc/sound_bloc/sound_bloc.dart';
import '../../utils/consts/custom_colors.dart';
import '../../utils/consts/custom_icons_img.dart';

class RecorderingTimer extends StatefulWidget {
  const RecorderingTimer({Key? key}) : super(key: key);

  @override
  State<RecorderingTimer> createState() => _RecorderingTimerState();
}

class _RecorderingTimerState extends State<RecorderingTimer> {
  late Timer _timer;
  void startTimer(SoundBloc _soundBloc) {
    _timer = Timer.periodic(const Duration(seconds: 1), (i) {
      if (!_soundBloc.sound.recorder.isRecording &&
          _soundBloc.sound.soundIndex == 0) {
        context.read<SoundBloc>().add(StartRecordEvent());
      }
      if (_soundBloc.sound.limit > 100) {
        context.read<SoundBloc>().add(StartRecordEvent());
        context.read<NavigationBloc>().add(
            StartRecordNavEvent(soundIndex: _soundBloc.sound.soundIndex + 1));
      }
      if (_soundBloc.sound.recorder.isRecording) {
        if (mounted) setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SoundBloc _soundBloc = BlocProvider.of<SoundBloc>(context);
    Size screen = MediaQuery.of(context).size;
    startTimer(_soundBloc);
    return Align(
        alignment: const Alignment(0, 0.3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageIcon(
              CustomIconsImg.ellipseRad,
              color: CustomColors.rad,
              size: screen.width * 0.02,
            ),
            SizedBox(
              width: screen.width * 0.02,
            ),
            Text(_soundBloc.sound.recorderTime),
          ],
        ));
  }
}
