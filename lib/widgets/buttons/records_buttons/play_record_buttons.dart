import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/navigation_bloc/navigation_bloc.dart';
import '../../../bloc/sound_bloc/sound_bloc.dart';
import '../../../utils/consts/custom_colors.dart';
import '../../../utils/consts/custom_icons_img.dart';

class PlayRecordButtons extends StatelessWidget {
  const PlayRecordButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    final SoundBloc _soundBloc = BlocProvider.of<SoundBloc>(context);
    return Container(
      width: screen.width * 1,
      foregroundDecoration: const BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.center,
          image: CustomIconsImg.play,
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Align(
        alignment: const Alignment(0, -0.75),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                if (_soundBloc.sound.audioPlayer.isPlaying ||
                    _soundBloc.sound.audioPlayer.isPaused) {
                  _soundBloc.sound.audioPlayer.seekToPlayer(Duration(
                      milliseconds: _soundBloc.sound.sliderPosition > 16000
                          ? _soundBloc.sound.sliderPosition - 15000
                          : 0));
                }
              },
              icon: const ImageIcon(
                CustomIconsImg.minus15,
                size: 25,
              ),
            ),
            IconButton(
              onPressed: () async {
                context.read<NavigationBloc>().add(StartRecordNavEvent(
                    soundIndex: _soundBloc.sound.soundIndex + 1));
                context.read<SoundBloc>().add(StartRecordEvent());
              },
              icon: const Icon(Icons.pause, color: CustomColors.invisible),
            ),
            IconButton(
              onPressed: () {
                if (_soundBloc.sound.audioPlayer.isPlaying ||
                    _soundBloc.sound.audioPlayer.isPaused) {
                  _soundBloc.sound.audioPlayer.seekToPlayer(Duration(
                      milliseconds: _soundBloc.sound.endOfSliderPosition >
                              _soundBloc.sound.sliderPosition + 16000
                          ? _soundBloc.sound.sliderPosition + 15000
                          : _soundBloc.sound.endOfSliderPosition - 1000));
                }
              },
              icon: const ImageIcon(
                CustomIconsImg.plus15,
                size: 25,
              ),
            ),
          ],
        ),
      ),
      height: screen.height * 0.25,
    );
  }
}
