import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../bloc/main_screen_block/main_screen_bloc.dart';
import '../../../models/audio.dart';
import '../../../models/tales_list.dart';
import '../../../repositorys/tales_list_repository.dart';
import '../../../services/minuts_text_convert_service.dart';
import '../../../services/sound_service.dart';
import '../../../utils/custom_colors.dart';
import '../../../utils/custom_icons.dart';
import '../../../utils/texts_consts.dart';
import '../../../widgets/uncategorized/active_tales_list_widget.dart';
import '../../../widgets/uncategorized/custom_clipper_widget.dart';
import '../../../widgets/uncategorized/play_all_button.dart';
import '../../../widgets/uncategorized/player_widget.dart';
import 'bloc/audio_screen_bloc.dart';

class AudiosScreen extends StatefulWidget {
  const AudiosScreen({Key? key}) : super(key: key);
  static const routeName = '/audios_screen.dart';

  @override
  State<AudiosScreen> createState() => _AudiosScreen();
}

class _AudiosScreen extends State<AudiosScreen> {
  @override
  Widget build(BuildContext context) {
    final List<AudioTale> _talesList =
        RepositoryProvider.of<TalesListRepository>(context)
            .getTalesListRepository()
            .getActiveTalesList();
    final Size _screen = MediaQuery.of(context).size;

    return Scaffold(
      appBar: _AudioScreenAppBar(
        onAction: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      body: Stack(
        children: [
          ClipPath(
            clipper: OvalBC(),
            child: Container(
              height: _screen.height / 5,
              color: CustomColors.audiotalesHeadColorBlue,
            ),
          ),
          Align(
            alignment: const Alignment(1, -0.8),
            child: SizedBox(
              height: _screen.height * 0.05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const _AudiosScreenListTextData(),
                  _talesList.isNotEmpty
                      ? _PlayAllTalesButtonWidget(
                          talesList: _talesList,
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, 1),
            child: SizedBox(
              height: _screen.height * 0.65,
              child: const ActiveTalesListWidget(
                color: CustomColors.audiotalesHeadColorBlue,
              ),
            ),
          ),
          const PlayerWidget(),
        ],
      ),
    );
  }
}

class _PlayAllTalesButtonWidget extends StatelessWidget {
  const _PlayAllTalesButtonWidget({
    Key? key,
    required this.talesList,
  }) : super(key: key);
  final List<AudioTale> talesList;
  @override
  Widget build(BuildContext context) {
    final SoundService _soundService =
        BlocProvider.of<MainScreenBloc>(context).sound;

    final Size _screen = MediaQuery.of(context).size;

    return BlocBuilder<AudioScreenBloc, AudioScreenState>(
      builder: (context, state) {
        return Stack(
          children: [
            Container(
              height: _screen.height * 0.05,
              width: _screen.width * 0.54,
              decoration: BoxDecoration(
                color: _soundService.isRepeatAllList
                    ? CustomColors.playAllButtonActiveRepeat
                    : CustomColors.playAllButtonDisactiveRepeat,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        context
                            .read<AudioScreenBloc>()
                            .add(AudioScreenChangeRepeatEvent());
                      },
                      icon: SvgPicture.asset(CustomIconsImg.repeat)),
                ],
              ),
            ),
            PlayAllTalesButtonWidget(
              talesList: talesList,
              textColor: CustomColors.blueSoso,
              backgroundColor: CustomColors.white,
            ),
          ],
        );
      },
      // ),
    );
  }
}

class _AudioScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const _AudioScreenAppBar({
    Key? key,
    this.onAction,
  }) : super(key: key);
  final void Function()? onAction;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    final Size _screen = MediaQuery.of(context).size;
    return AppBar(
      backgroundColor: CustomColors.audiotalesHeadColorBlue,
      elevation: 0,
      flexibleSpace: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          SizedBox(),
          _AudiosScreenText(),
        ],
      ),
      leading: Padding(
        padding: EdgeInsets.only(
          left: _screen.width * 0.04,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: SvgPicture.asset(
                CustomIconsImg.drawer,
                height: 25,
                color: CustomColors.white,
              ),
              onPressed: onAction,
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class _AudiosScreenText extends StatelessWidget {
  const _AudiosScreenText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Column(
      children: [
        Text(
          TextsConst.audiofiles,
          style: TextStyle(
              color: CustomColors.white,
              fontWeight: FontWeight.bold,
              fontSize: screen.width * 0.07),
        ),
        Text(
          TextsConst.selectionsTextAllInOnePlace,
          style: TextStyle(
              color: CustomColors.white, fontSize: screen.width * 0.03),
        )
      ],
    );
  }
}

class _AudiosScreenListTextData extends StatelessWidget {
  const _AudiosScreenListTextData({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size _screen = MediaQuery.of(context).size;
    final TalesList _talesList =
        context.read<TalesListRepository>().getTalesListRepository();
    final num _millisecondsListTime =
        _talesList.getActiveTalesFullTime() * 60000;
    final String _selectionFullTime = DateTime.fromMillisecondsSinceEpoch(
            _millisecondsListTime.toInt(),
            isUtc: true)
        .toString()
        .substring(11, 16);

    final String _textAudio =
        _talesList.getActiveTalesList().length.toString() +
            TextsConst.selectionAudioText;

    final String _textTime = _selectionFullTime +
        TimeTextConvertService.instance.getConvertedHouresText(
            timeInHoures: _millisecondsListTime / 3600000);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            _textAudio,
            style: TextStyle(
              color: CustomColors.white,
              fontSize: _screen.height * 0.015,
            ),
          ),
        ),
        Flexible(
          child: Text(
            _textTime,
            style: TextStyle(
              color: CustomColors.white,
              fontSize: _screen.height * 0.015,
            ),
          ),
        ),
      ],
    );
  }
}
