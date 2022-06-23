import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../models/audio.dart';
import '../../pages/main_screen/audios_screen/bloc/audio_screen_bloc.dart';
import '../../pages/main_screen/main_screen_block/main_screen_bloc.dart';
import '../../services/sound_service.dart';
import '../../utils/consts/custom_icons_img.dart';
import '../../utils/consts/texts_consts.dart';

class PlayAllTalesButtonWidget extends StatelessWidget {
  const PlayAllTalesButtonWidget(
      {Key? key,
      required this.talesList,
      required this.textColor,
      required this.backgroundColor})
      : super(key: key);
  final List<AudioTale> talesList;
  final Color textColor;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    final SoundService _soundService =
        BlocProvider.of<MainScreenBloc>(context).sound;

    Size screen = MediaQuery.of(context).size;

    return BlocBuilder<AudioScreenBloc, AudioScreenState>(
      builder: (context, state) {
        return Stack(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                context
                    .read<AudioScreenBloc>()
                    .add(AudioScreenPlayAllEvent(talesList: talesList));
              },
              child: Container(
                height: screen.height * 0.05,
                width: screen.width * 0.41,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(screen.height * 0.005),
                      child: _soundService.audioPlayer.isPlaying
                          ? SvgPicture.asset(
                              CustomIconsImg.pauseAll,
                              color: textColor,
                              height: screen.height * 0.04,
                            )
                          : ImageIcon(
                              CustomIconsImg.playBlueSolo,
                              color: textColor,
                              size: screen.height * 0.04,
                            ),
                    ),
                    _soundService.audioPlayer.isPlaying
                        ? _AudioScreenPlayAllTextF(color: textColor)
                        : _AudioScreenPlayAllTextT(color: textColor),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _AudioScreenPlayAllTextT extends StatelessWidget {
  const _AudioScreenPlayAllTextT({Key? key, required this.color})
      : super(key: key);

  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(TextsConst.audioScreenPlayAllT, style: TextStyle(color: color));
  }
}

class _AudioScreenPlayAllTextF extends StatelessWidget {
  const _AudioScreenPlayAllTextF({Key? key, required this.color})
      : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    // Size screen = MediaQuery.of(context).size;
    return Text(TextsConst.audioScreenPlayAllF, style: TextStyle(color: color));
  }
}
