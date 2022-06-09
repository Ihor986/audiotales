import 'dart:async';
import 'package:audiotales/utils/consts/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../utils/consts/custom_icons_img.dart';
import '../../sound_bloc/sound_bloc.dart';

class RecorderingAnimation extends StatefulWidget {
  const RecorderingAnimation({Key? key}) : super(key: key);

  @override
  State<RecorderingAnimation> createState() => _RecorderingAnimationState();
}

class _RecorderingAnimationState extends State<RecorderingAnimation> {
  List lines = [
    CustomIconsImg.power0,
    CustomIconsImg.power1,
    CustomIconsImg.power1,
    CustomIconsImg.power2,
    CustomIconsImg.power2,
    CustomIconsImg.power3,
    CustomIconsImg.power3,
    CustomIconsImg.power3,
    CustomIconsImg.power3,
    CustomIconsImg.power3,
    CustomIconsImg.power3,
  ];

  List<Widget> children = [];

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    final SoundBloc _soundBloc = BlocProvider.of<SoundBloc>(context);
    return StreamBuilder<Object>(
        stream: Stream.periodic(const Duration(seconds: 1), (i) => i),
        builder: (context, snapshot) {
          if (_soundBloc.sound.recorder.isRecording) {
            children.add(Image(
              image: context.read<SoundBloc>().sound.recorderPower.round() > 10
                  ? lines[10]
                  : lines[_soundBloc.sound.recorderPower.round()],
              height: screen.height * 0.1,
            ));
            if (children.length > 45) {
              children.removeAt(0);
            }
          }

          return timer(_soundBloc, screen);
        });
  }

  Widget timer(soundBloc, screen) {
    return Align(
      alignment: const Alignment(0, -0.2),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: screen.height * 0.1,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                height: screen.height * 0.1,
                width: screen.width,
                decoration: const BoxDecoration(
                  color: CustomColors.white,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: children,
              )
            ],
          ),
        ),
      ),
    );
  }
}
