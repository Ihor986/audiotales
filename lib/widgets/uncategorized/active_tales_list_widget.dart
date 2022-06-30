import 'package:audiotales/utils/consts/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../models/audio.dart';
import '../../models/tales_list.dart';
import '../../repositorys/tales_list_repository.dart';
import '../../utils/consts/custom_icons_img.dart';
import '../texts/audio_list_text/audio_list_text.dart';
import '../../pages/main_screen/main_screen_block/main_screen_bloc.dart';
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

        return ListView.builder(
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
                              AudioListNameText(
                                audio: _talesList.elementAt(i),
                              ),
                              AudioListText(
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
                _talesList.elementAt(i),
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
