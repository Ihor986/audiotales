import 'dart:async';
import 'package:audiotales/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../utils/custom_icons.dart';
import '../../record_bloc/record_bloc.dart';

class RecorderingAnimation extends StatefulWidget {
  const RecorderingAnimation({Key? key}) : super(key: key);

  @override
  State<RecorderingAnimation> createState() => _RecorderingAnimationState();
}

class _RecorderingAnimationState extends State<RecorderingAnimation> {
  final List _lines = [
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

  final List<Widget> _children = [];

  @override
  Widget build(BuildContext context) {
    final Size _screen = MediaQuery.of(context).size;
    final RecordBloc _soundBloc = BlocProvider.of<RecordBloc>(context);
    return StreamBuilder<Object>(
      stream: Stream.periodic(const Duration(seconds: 1), (i) => i),
      builder: (context, snapshot) {
        if (_soundBloc.sound.recorder.isRecording) {
          _children.add(
            SvgPicture.asset(
              context.read<RecordBloc>().sound.recorderPower.round() > 10
                  ? _lines[10]
                  : _lines[_soundBloc.sound.recorderPower.round()],
              color: CustomColors.black,
              height: _screen.height * 0.1,
            ),
          );
          if (_children.length > 45) {
            _children.removeAt(0);
          }
        }

        return Align(
          alignment: const Alignment(0, -0.2),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: _screen.height * 0.1,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    height: _screen.height * 0.1,
                    width: _screen.width,
                    decoration: const BoxDecoration(
                      color: CustomColors.white,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: _children,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
