import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../utils/custom_colors.dart';
import '../../../../../utils/custom_icons.dart';
import '../../sound_bloc/sound_bloc.dart';

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
          SvgPicture.asset(
            CustomIconsImg.ellipseRad,
            color: CustomColors.red,
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
