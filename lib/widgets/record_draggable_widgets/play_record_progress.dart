import 'package:audiotales/utils/consts/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/sound_bloc/sound_bloc.dart';

class PlayRecordProgres extends StatefulWidget {
  const PlayRecordProgres({Key? key}) : super(key: key);

  @override
  State<PlayRecordProgres> createState() => _PlayRecordProgresState();
}

class _PlayRecordProgresState extends State<PlayRecordProgres> {
  @override
  Widget build(BuildContext context) {
    final SoundBloc _soundBloc = BlocProvider.of<SoundBloc>(context);
    return StreamBuilder<Object>(
        stream: Stream.periodic(const Duration(seconds: 1), (i) => i),
        builder: (context, snapshot) {
          return _play(_soundBloc);
        });
  }

  Widget _play(SoundBloc soundBloc) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SliderTheme(
          data: const SliderThemeData(
              activeTrackColor: CustomColors.black,
              inactiveTrackColor: CustomColors.black,
              thumbColor: CustomColors.black,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5)),
          child: Slider(
            value: soundBloc.sound.sliderPosition.toDouble(),
            min: 0.0,
            max: soundBloc.sound.endOfSliderPosition.toDouble(),
            onChanged: (double d) async {
              soundBloc.sound.sliderPosition = d.floor();
              setState(() {
                if (soundBloc.sound.audioPlayer.isPlaying ||
                    soundBloc.sound.audioPlayer.isPaused) {
                  soundBloc.sound.audioPlayer
                      .seekToPlayer(Duration(milliseconds: d.floor()));
                }
              });
            }, // setSubscriptionDuration,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(soundBloc.sound.sliderPositionText),
              Text(soundBloc.sound.endOfSliderPositionText)
            ],
          ),
        )
      ],
    );
  }
}
