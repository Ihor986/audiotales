import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/sound_bloc/sound_bloc.dart';
import '../../services/audioService.dart';
import '../../utils/consts/custom_icons_img.dart';

class RecorderingAnimation extends StatefulWidget {
  RecorderingAnimation({Key? key}) : super(key: key);

  @override
  State<RecorderingAnimation> createState() => _RecorderingAnimationState();
}

class _RecorderingAnimationState extends State<RecorderingAnimation> {
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    SoundService sound =
        BlocProvider.of<SoundBloc>(context, listen: true).sound;
    List lines = [
      CustomIconsImg.powerLine6,
      CustomIconsImg.powerLine6,
      CustomIconsImg.powerLine5,
      CustomIconsImg.powerLine4,
      CustomIconsImg.powerLine3,
      CustomIconsImg.powerLine2,
      CustomIconsImg.powerLine2,
      CustomIconsImg.powerLine1,
      CustomIconsImg.powerLine1,
      CustomIconsImg.powerLine,
      CustomIconsImg.powerLine,
    ];
    int length1 = 0;

    Timer.periodic(Duration(seconds: 1), (i) {
      int length2 = 0;
      if (sound.recorder.isRecording && length1 == length2) {
        sound.children.add(Padding(
          padding: EdgeInsets.all(screen.width * 0.005),
          child: Image(
            image: sound.recorderPower.round() > 10
                ? lines[10]
                : lines[sound.recorderPower.round()],
            height: screen.height * 0.1,
            //
          ),
        ));
        length1++;
        length2++;
        if (sound.children.length > 33) {
          sound.children.removeAt(0);
        }
        setState(() {});
      }
    });

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
                    image: DecorationImage(image: CustomIconsImg.line)),
              ),
              Row(
                children: sound.children,
              )
            ],
          ),
        ),
      ),
    );
  }
}
