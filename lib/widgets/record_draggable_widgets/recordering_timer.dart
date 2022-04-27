import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/sound_bloc/sound_bloc.dart';
import '../../services/audioService.dart';
import '../../utils/consts/custom_colors.dart';
import '../../utils/consts/custom_icons_img.dart';

class RecorderingTimer extends StatefulWidget {
  const RecorderingTimer({Key? key}) : super(key: key);

  @override
  State<RecorderingTimer> createState() => _RecorderingTimerState();
}

class _RecorderingTimerState extends State<RecorderingTimer> {
  @override
  Widget build(BuildContext context) {
    num screenWidth = MediaQuery.of(context).size.width;
    SoundService sound =
        BlocProvider.of<SoundBloc>(context, listen: true).sound;
    Timer.periodic(Duration(seconds: 1), (i) {
      if (sound.recorder.isRecording) {
        setState(() {});
      }
    });

    return Align(
        alignment: const Alignment(0, 0.3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageIcon(
              CustomIconsImg.ellipseRad,
              color: CustomColors.rad,
              size: screenWidth * 0.02,
            ),
            SizedBox(
              width: screenWidth * 0.02,
            ),
            Text(sound.recorderTime),
          ],
        ));
  }
}
