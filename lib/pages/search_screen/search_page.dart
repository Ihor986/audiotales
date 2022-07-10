import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../repositorys/tales_list_repository.dart';
import '../../../../../widgets/uncategorized/custom_clipper_widget.dart';
import '../../bloc/main_screen_block/main_screen_bloc.dart';
import '../../models/tale.dart';
import '../../models/tales_list.dart';
import '../../services/minuts_text_convert_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_icons.dart';
import '../../utils/texts_consts.dart';
import '../../widgets/uncategorized/custom_popup_menu_active_playlist.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);
  static const routeName = '/search_screen.dart';

  @override
  Widget build(BuildContext context) {
    final Size _screen = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Column(
            children: [
              ClipPath(
                clipper: OvalBC(),
                child: Container(
                  alignment: const Alignment(0, -0.8),
                  height: _screen.height * 0.3,
                  color: CustomColors.audiotalesHeadColorBlue,
                  child: _SearchScreenAppBar(
                    onAction: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
              ),
            ],
          ),
          const Align(
            alignment: Alignment(0, -0.7),
            child: _SelectAudioSearchWidget(),
          ),
          const Align(
            alignment: Alignment(0, 1),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: _AudiolistSelectAudioWidget(),
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}

class _SearchScreenAppBar extends StatelessWidget {
  const _SearchScreenAppBar({
    Key? key,
    required this.onAction,
  }) : super(key: key);
  final void Function() onAction;

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Container(
      height: 0.2 * screen.height,
      color: CustomColors.audiotalesHeadColorBlue,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 0.04 * screen.height,
            ),
            child: Stack(
              children: [
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: _SearchAppBarText(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(
                        CustomIconsImg.drawer,
                        height: 0.02 * screen.height,
                        color: CustomColors.white,
                      ),
                      padding: const EdgeInsets.all(0),
                      onPressed: onAction,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AudiolistSelectAudioWidget extends StatelessWidget {
  const _AudiolistSelectAudioWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenBloc, MainScreenState>(
      builder: (context, state) {
        final List<AudioTale> _tales =
            RepositoryProvider.of<TalesListRepository>(context)
                .getTalesListRepository()
                .getActiveTalesList();
        final Size _screen = MediaQuery.of(context).size;
        List<AudioTale> _talesList = _tales;
        if (state.searchValue != null) {
          _talesList = _tales
              .where((element) => element.name
                  .toLowerCase()
                  .contains(state.searchValue?.toLowerCase() ?? ''))
              .toList();
        }
        return SizedBox(
          height: _screen.height * 0.7,
          child: ListView.builder(
            itemCount: _talesList.length,
            itemBuilder: (_, i) {
              return Padding(
                padding: EdgeInsets.all(_screen.height * 0.005),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          _PlayButton(
                            color: CustomColors.audiotalesHeadColorBlue,
                            i: i,
                          ),
                          SizedBox(
                            width: _screen.width * 0.05,
                          ),
                          Column(
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
                        ],
                      ),
                      CustomPopUpMenu(
                        audio: _talesList[i],
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

class _SelectAudioSearchWidget extends StatelessWidget {
  const _SelectAudioSearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MainScreenBloc _mainScreenBloc =
        BlocProvider.of<MainScreenBloc>(context);
    return Container(
      decoration: BoxDecoration(
        color: CustomColors.white,
        boxShadow: const [
          BoxShadow(
            color: CustomColors.boxShadow,
            offset: Offset(0, 5),
            blurRadius: 6,
          ),
        ],
        borderRadius: BorderRadius.circular(41),
      ),
      width: 309,
      height: 59,
      child: TextFormField(
        autofocus: false,
        onChanged: (value) {
          _mainScreenBloc.add(SearchAudioEvent(value: value));
        },
        textAlign: TextAlign.start,
        cursorRadius: const Radius.circular(41.0),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20),
          hintText: TextsConst.search,
          hintStyle: const TextStyle(color: CustomColors.noTalesText),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(41.0)),
              borderSide: BorderSide(color: CustomColors.white, width: 2.0)),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(41.0)),
              borderSide: BorderSide(color: CustomColors.white, width: 2.0)),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SvgPicture.asset(
              CustomIconsImg.search,
              color: CustomColors.black,
            ),
          ),
          suffixIconColor: CustomColors.black,
        ),
      ),
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
        String _text = TimeTextConvertService.instance
            .getConvertedMinutesText(timeInMinutes: audio.time);

        return audio.id != state.chahgedAudioId
            ? Text(
                '${audio.time.round()} $_text',
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

class _SearchAppBarText extends StatelessWidget {
  const _SearchAppBarText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Column(
      children: [
        Text(
          TextsConst.searchTittle,
          style: TextStyle(
              color: CustomColors.white,
              fontWeight: FontWeight.bold,
              fontSize: screen.width * 0.07),
        ),
        Text(
          TextsConst.searchTittle2,
          style: TextStyle(
              color: CustomColors.white, fontSize: screen.width * 0.03),
        )
      ],
    );
  }
}
