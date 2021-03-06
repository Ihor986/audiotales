import 'package:audiotales/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../bloc/main_screen_block/main_screen_bloc.dart';
import '../../models/tale.dart';
import '../../models/tales_list.dart';
import '../../repositories/tales_list_repository.dart';
import '../../services/minuts_text_convert_service.dart';
import '../../utils/custom_icons.dart';
import 'custom_popup_menu_active_playlist.dart';

class ActiveTalesListWidget extends StatelessWidget {
  const ActiveTalesListWidget({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenBloc, MainScreenState>(
      builder: (context, state) {
        final Size screen = MediaQuery.of(context).size;
        final TalesList _talesListRep =
            context.read<TalesListRepository>().getTalesListRepository();
        final List<AudioTale> _talesList = _talesListRep.getActiveTalesList();
        return Stack(
          children: [
            ListView.builder(
              itemCount: _talesList.length,
              itemBuilder: (_, i) {
                return Padding(
                  padding: EdgeInsets.all(screen.height * 0.005),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            _PlayButton(
                              color: color,
                              i: i,
                            ),
                            SizedBox(
                              width: screen.width * 0.05,
                            ),
                            SizedBox(
                              height: screen.height * 0.07,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _AudioListNameText(
                                    audio: _talesList.elementAt(i),
                                  ),
                                  _AudioListText(
                                    audio: _talesList.elementAt(i),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        CustomPopUpMenu(
                          audio: _talesList.elementAt(i),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: CustomColors.white,
                      border: Border.all(color: CustomColors.audioBorder),
                      borderRadius: const BorderRadius.all(Radius.circular(41)),
                    ),
                  ),
                );
              },
            ),
            // const PlayerWidget(),
          ],
        );
      },
    );
  }
}

class _PlayButton extends StatelessWidget {
  const _PlayButton({
    Key? key,
    required this.i,
    required this.color,
  }) : super(key: key);

  final Color color;
  final int i;

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    final MainScreenBloc _mainScreenBloc = context.read<MainScreenBloc>();
    final TalesList _talesListRep =
        context.read<TalesListRepository>().getTalesListRepository();
    final List<AudioTale> _talesList = _talesListRep.getActiveTalesList();
    final String _id = _talesList.elementAt(i).id;
    final FlutterSoundPlayer _player = _mainScreenBloc.sound.audioPlayer;
    return AnimatedBuilder(
      animation: _mainScreenBloc.sound,
      builder: (context, child) {
        return IconButton(
          onPressed: () {
            _mainScreenBloc.add(
              ClickPlayEvent(
                audioList: _talesList,
                indexAudio: i,
              ),
            );
          },
          icon: _player.isPlaying && _id == _mainScreenBloc.sound.idPlaying
              ? SvgPicture.asset(
                  CustomIconsImg.pauseAll,
                  color: color,
                )
              : SvgPicture.asset(
                  CustomIconsImg.playSVG,
                  color: color,
                ),
          iconSize: screen.height * 0.05,
        );
      },
    );
  }
}

class _AudioListText extends StatelessWidget {
  const _AudioListText({
    Key? key,
    required this.audio,
  }) : super(key: key);
  final AudioTale audio;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenBloc, MainScreenState>(
      buildWhen: (previous, current) {
        return previous.readOnly != current.readOnly;
      },
      builder: (context, state) {
        String text = TimeTextConvertService.instance
            .getConvertedMinutesText(timeInMinutes: audio.time);

        return audio.id != state.chahgedAudioId
            ? Text(
                '${audio.time.round()} $text',
                style: const TextStyle(
                  color: CustomColors.noTalesText,
                  fontFamily: 'TT Norms',
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                ),
              )
            : const SizedBox();
      },
    );
  }
}

class _AudioListNameText extends StatelessWidget {
  const _AudioListNameText({
    Key? key,
    required this.audio,
  }) : super(key: key);
  final AudioTale audio;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenBloc, MainScreenState>(
      buildWhen: (previous, current) {
        return previous.readOnly != current.readOnly;
      },
      builder: (context, state) {
        final TalesList _talesListRep =
            context.read<TalesListRepository>().getTalesListRepository();
        Size screen = MediaQuery.of(context).size;
        final bool _readOnly =
            audio.id == state.chahgedAudioId ? state.readOnly : true;
        return _readOnly
            ? Text(audio.name)
            : SizedBox(
                height: screen.height * 0.03,
                width: 0.5 * screen.width,
                child: TextFormField(
                  decoration: InputDecoration(
                    border: _readOnly ? InputBorder.none : null,
                  ),
                  initialValue: audio.name,
                  onChanged: (value) {
                    context.read<MainScreenBloc>().add(
                          EditingAudioNameEvent(value: value),
                        );
                  },
                  onEditingComplete: () {
                    context
                        .read<MainScreenBloc>()
                        .add(SaveChangedAudioNameEvent(
                          audio: audio,
                          fullTalesList: _talesListRep,
                        ));
                  },
                  readOnly: _readOnly,
                  style: const TextStyle(
                    color: CustomColors.black,
                    fontFamily: 'TT Norms',
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                  ),
                ),
              );
      },
    );
  }
}
