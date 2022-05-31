import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../models/audio.dart';
import '../../../repositorys/tales_list_repository.dart';
import '../../../services/sound_service.dart';
import '../../../utils/consts/custom_colors.dart';
import '../../../utils/consts/custom_icons_img.dart';
import '../../../widgets/uncategorized/custom_clipper_widget.dart';
import '../../../widgets/uncategorized/active_tales_list_widget.dart';
import '../main_screen_block/main_screen_bloc.dart';
import 'bloc/audio_screen_bloc.dart';
import 'widgets/audios_screen_text.dart';

class AudiosScreen extends StatefulWidget {
  const AudiosScreen({Key? key}) : super(key: key);
  static const routeName = '/audios_screen.dart';
  static const AudiosScreenText title = AudiosScreenText();

  @override
  State<AudiosScreen> createState() => _AudiosScreen();
}

class _AudiosScreen extends State<AudiosScreen> {
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return Stack(
      children: [
        ClipPath(
          clipper: OvalBC(),
          child: Container(
            height: screen.height / 4.5,
            color: CustomColors.audiotalesHeadColorBlue,
          ),
        ),
        Align(
          alignment: const Alignment(1, -0.8),
          child: SizedBox(
            height: screen.height * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                AudiosScreenListTextData(),
                _PlayAllTalesButtonWidget(),
              ],
            ),
          ),
        ),
        Align(
            alignment: const Alignment(0, 1),
            child: SizedBox(
                height: screen.height * 0.65,
                child: const ActiveTalesListWidget())),
      ],
    );
  }
}

class _PlayAllTalesButtonWidget extends StatelessWidget {
  const _PlayAllTalesButtonWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final SoundService _soundService =
        BlocProvider.of<MainScreenBloc>(context).sound;
    final List<AudioTale> talesList =
        RepositoryProvider.of<TalesListRepository>(context)
            .getTalesListRepository()
            .getActiveTalesList();
    Size screen = MediaQuery.of(context).size;

    return MultiBlocProvider(
      providers: [
        BlocProvider<AudioScreenBloc>(
          create: (_) => AudioScreenBloc(_soundService),
        ),
      ],
      child: BlocBuilder<AudioScreenBloc, AudioScreenState>(
        builder: (context, state) {
          return Stack(
            children: [
              Container(
                height: screen.height * 0.05,
                width: screen.width * 0.54,
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
                    color: CustomColors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screen.height * 0.005),
                        child: _soundService.audioPlayer.isPlaying
                            ? SvgPicture.asset(
                                CustomIconsImg.pauseAll,
                                color: CustomColors.blueSoso,
                                height: screen.height * 0.04,
                              )
                            : ImageIcon(
                                CustomIconsImg.playBlueSolo,
                                color: CustomColors.blueSoso,
                                size: screen.height * 0.04,
                              ),
                      ),
                      _soundService.audioPlayer.isPlaying
                          ? const AudioScreenPlayAllTextF()
                          : const AudioScreenPlayAllTextT(),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
