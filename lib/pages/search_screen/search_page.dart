import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../models/audio.dart';
import '../../../../../repositorys/tales_list_repository.dart';
import '../../../../../utils/consts/custom_colors.dart';
import '../../../../../utils/consts/custom_icons_img.dart';
import '../../../../../utils/consts/texts_consts.dart';
import '../../../../../widgets/texts/audio_list_text/audio_list_text.dart';
import '../../../../../widgets/uncategorized/custom_clipper_widget.dart';

import '../../widgets/uncategorized/custom_popup_menu_active_playlist.dart';
import '../main_screen/main_screen_block/main_screen_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);
  static const routeName = '/select_audio_screen.dart';

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return Stack(
      children: [
        Column(
          children: [
            ClipPath(
              clipper: OvalBC(),
              child: Container(
                height: screen.height * 0.15,
                color: CustomColors.audiotalesHeadColorBlue,
              ),
            ),
          ],
        ),
        const Align(
          alignment: Alignment(0, -0.9),
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
        final MainScreenBloc _mainScreenBloc =
            BlocProvider.of<MainScreenBloc>(context);
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
                              _mainScreenBloc.add(ClickPlayEvent(talesList[i]));
                            },
                            icon: ImageIcon(
                              CustomIconsImg.playBlueSolo,
                              color: CustomColors.audiotalesHeadColorBlue,
                              size: screen.height,
                            ),
                          ),
                          SizedBox(
                            width: screen.width * 0.05,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_talesList[i].name),
                              AudioListText(time: _talesList[i].time),
                            ],
                          ),
                        ],
                      ),
                      CustomPopUpMenu(
                        id: _talesList[i].id,
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
    // return BlocBuilder<MainScreenBloc, MainScreenState>(
    //   builder: (context, state) {
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
    //   },
    // );
  }
}
