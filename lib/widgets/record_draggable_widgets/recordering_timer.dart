import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/sound_bloc/sound_bloc.dart';
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
    final SoundBloc _soundBloc = BlocProvider.of<SoundBloc>(context);
    return StreamBuilder<Object>(
      stream: Stream.periodic(const Duration(seconds: 1), (i) => i),
      builder: (context, snapshot) {
        if (_soundBloc.sound.limit >= 100) {
          context.read<SoundBloc>().add(StartRecordEvent());
        }
        return timer(_soundBloc);
      },
    );
  }

  Widget timer(_soundBloc) {
    Size screen = MediaQuery.of(context).size;
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
      ),
    );
  }
}
