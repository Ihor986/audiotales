import 'package:audiotales/pages/search_screen/widgets/search_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../models/audio.dart';
import '../../../../../repositorys/tales_list_repository.dart';
import '../../../../../utils/consts/custom_colors.dart';
import '../../services/minuts_text_convert_service.dart';
import '../../utils/consts/custom_icons.dart';
import '../../../../../utils/consts/texts_consts.dart';
import '../../../../../widgets/uncategorized/custom_clipper_widget.dart';
import '../../widgets/uncategorized/custom_popup_menu_active_playlist.dart';
import '../main_screen/main_screen_block/main_screen_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);
  static const routeName = '/search_screen.dart';

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

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
                  height: screen.height * 0.3,
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
      height: 0.16 * screen.height,
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
                    child: SearchAppBarText(),
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
        final List<AudioTale> talesList =
            RepositoryProvider.of<TalesListRepository>(context)
                .getTalesListRepository()
                .getActiveTalesList();
        final Size screen = MediaQuery.of(context).size;
        final MainScreenBloc _mainScreenBloc = context.read<MainScreenBloc>();
        List<AudioTale> _talesList = talesList;
        if (state.searchValue != null) {
          _talesList = talesList
              .where(
                  (element) => element.name.contains(state.searchValue ?? ''))
              .toList();
        }
        return SizedBox(
          height: screen.height * 0.7,
          child: ListView.builder(
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
                          IconButton(
                            onPressed: () {
                              _mainScreenBloc.add(ClickPlayEvent(
                                audioList: talesList,
                                indexAudio: i,
                              ));
                            },
                            icon: SvgPicture.asset(
                              CustomIconsImg.playSVG,
                              color: CustomColors.audiotalesHeadColorBlue,
                            ),
                            iconSize: 0.05 * screen.height,
                          ),
                          SizedBox(
                            width: screen.width * 0.05,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_talesList[i].name),
                              _AudioListText(audio: _talesList.elementAt(i)),
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
              borderSide: BorderSide(
                  color: Color.fromRGBO(246, 246, 246, 1), width: 2.0)),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(41.0)),
              borderSide: BorderSide(
                  color: Color.fromRGBO(246, 246, 246, 1), width: 2.0)),
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
