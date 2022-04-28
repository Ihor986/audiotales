import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/sound_bloc/sound_bloc.dart';
import '../../utils/consts/custom_icons_img.dart';

class RecorderingAnimation extends StatefulWidget {
  const RecorderingAnimation({Key? key}) : super(key: key);

  @override
  State<RecorderingAnimation> createState() => _RecorderingAnimationState();
}

class _RecorderingAnimationState extends State<RecorderingAnimation> {
  List lines = [
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
    CustomIconsImg.powerLine,
  ];
  late Timer _timer;
  int length1 = 0;
  void startTimer(SoundBloc _soundBloc, Size screen) {
    int length2 = 0;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_soundBloc.sound.recorder.isRecording && length2 == 0) {
        _soundBloc.sound.children.add(Padding(
          padding: EdgeInsets.all(screen.width * 0.005),
          child: Image(
            image: context.read<SoundBloc>().sound.recorderPower.round() > 10
                ? lines[10]
                : lines[_soundBloc.sound.recorderPower.round()],
            height: screen.height * 0.1,
            //
          ),
        ));
        length1++;
        length2++;
        if (_soundBloc.sound.children.length > 33) {
          _soundBloc.sound.children.removeAt(0);
        }
        if (mounted) setState(() {});
      }
      // if (!_soundBloc.sound.recorder.isRecording && length1 > 0) {
      //   print('${_soundBloc.sound.recorder.isRecording} $length1');
      //   _timer.cancel();
      // }
      // print('${_soundBloc.sound.recorder.isRecording} $length1');
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

    startTimer(_soundBloc, screen);

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
                children: _soundBloc.sound.children,
              )
            ],
          ),
        ),
      ),
    );
  }
}
