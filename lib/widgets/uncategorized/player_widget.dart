import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../bloc/main_screen_block/main_screen_bloc.dart';
import '../../models/tale.dart';
import '../../models/tales_list.dart';
import '../../repositorys/tales_list_repository.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_icons.dart';

class PlayerWidget extends StatelessWidget {
  const PlayerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    final MainScreenBloc _mainScreenBloc = context.read<MainScreenBloc>();
    final FlutterSoundPlayer _player = _mainScreenBloc.sound.audioPlayer;
    return Align(
      alignment: const Alignment(0, 0.6),
      child: AnimatedBuilder(
        animation: _mainScreenBloc.sound,
        builder: (context, child) {
          return _player.isPlaying ||
                  _mainScreenBloc.sound.isPlayingList == true
              ? Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: CustomColors.audioBorder),
                    borderRadius: const BorderRadius.all(Radius.circular(41)),
                    color: CustomColors.blueSoso,
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            _PlayButton(
                              color: CustomColors.white,
                            ),
                            _ForwardButton(
                              color: CustomColors.white,
                            )
                          ],
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _mainScreenBloc.sound.audioList
                                  .elementAt(_mainScreenBloc.sound.listIndex)
                                  .name,
                              style: const TextStyle(
                                color: CustomColors.white,
                              ),
                            ),
                            const _PlayRecordProgres(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  height: 0.1 * screen.height,
                )
              : const SizedBox();
        },
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  const _PlayButton({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    final MainScreenBloc _mainScreenBloc = context.read<MainScreenBloc>();
    final TalesList _talesListRep =
        context.read<TalesListRepository>().getTalesListRepository();
    final List<AudioTale> _talesList = _talesListRep.getActiveTalesList();
    return AnimatedBuilder(
      animation: _mainScreenBloc.sound,
      builder: (context, child) {
        return IconButton(
          icon: SvgPicture.asset(
            CustomIconsImg.pauseAll,
            color: color,
          ),
          iconSize: screen.height * 0.08,
          onPressed: () {
            _mainScreenBloc.add(
              ClickPlayEvent(
                audioList: _talesList,
                indexAudio: 0,
              ),
            );
          },
        );
      },
    );
  }
}

class _PlayRecordProgres extends StatefulWidget {
  const _PlayRecordProgres({Key? key}) : super(key: key);

  @override
  State<_PlayRecordProgres> createState() => _PlayRecordProgresState();
}

class _PlayRecordProgresState extends State<_PlayRecordProgres> {
  @override
  Widget build(BuildContext context) {
    final MainScreenBloc _mainScreenBloc = context.read<MainScreenBloc>();
    final Size screen = MediaQuery.of(context).size;
    return StreamBuilder<Object>(
      stream: Stream.periodic(const Duration(seconds: 1), (i) => i),
      builder: (context, snapshot) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 0.02 * screen.height,
              width: 0.75 * screen.width,
              child: SliderTheme(
                data: const SliderThemeData(
                    activeTrackColor: CustomColors.white,
                    inactiveTrackColor: CustomColors.white,
                    thumbColor: CustomColors.white,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5)),
                child: Slider(
                  value: _mainScreenBloc.sound.sliderPosition.toDouble(),
                  min: 0.0,
                  max: _mainScreenBloc.sound.audioPlayer.isStopped
                      ? _mainScreenBloc.sound.sliderPosition.toDouble()
                      : _mainScreenBloc.sound.endOfSliderPosition.toDouble(),
                  onChanged: (double d) async {
                    setState(() {
                      _mainScreenBloc.sound.forwardPlayerWithSlider(d);
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              width: 0.6 * screen.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _mainScreenBloc.sound.audioPlayer.isStopped
                        ? _mainScreenBloc.sound.endOfSliderPositionText
                            .substring(3)
                        : _mainScreenBloc.sound.sliderPositionText.substring(3),
                    style: const TextStyle(
                      color: CustomColors.white,
                    ),
                  ),
                  Text(
                    _mainScreenBloc.sound.endOfSliderPositionText.substring(3),
                    style: const TextStyle(
                      color: CustomColors.white,
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

class _ForwardButton extends StatelessWidget {
  const _ForwardButton({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    final MainScreenBloc _mainScreenBloc = context.read<MainScreenBloc>();
    return AnimatedBuilder(
      animation: _mainScreenBloc.sound,
      builder: (context, child) {
        return IconButton(
          icon: SvgPicture.asset(
            CustomIconsImg.forwardVector,
            color: color,
          ),
          iconSize: screen.height * 0.08,
          onPressed: () {
            _mainScreenBloc.add(
              NextTreckEvent(),
            );
          },
        );
      },
    );
  }
}
