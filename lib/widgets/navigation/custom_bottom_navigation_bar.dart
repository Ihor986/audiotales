import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/main_screen_block/main_screen_bloc.dart';
import '../../bloc/navigation_bloc/navigation_bloc.dart';
import '../../services/audio_service.dart';
import '../../utils/consts/custom_colors.dart';
import '../../utils/consts/custom_icons_img.dart';
import '../../utils/consts/texts_consts.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SoundService _sound = BlocProvider.of<MainScreenBloc>(context).sound;

    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Container(
          foregroundDecoration: BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.center,
              image: state.currentIndex == 2
                  ? _sound.getNavImg()
                  : CustomIconsImg.mic,
              fit: BoxFit.fitHeight,
            ),
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: CustomColors.boxShadow,
                  spreadRadius: 3,
                  blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                    activeIcon: ImageIcon(
                      CustomIconsImg.home,
                      size: 25,
                      color: CustomColors.blueSoso,
                    ),
                    icon: ImageIcon(
                      CustomIconsImg.home,
                      size: 25,
                      color: CustomColors.iconsColorBNB,
                    ),
                    label: TextsConst.head),
                BottomNavigationBarItem(
                    backgroundColor: Colors.green,
                    activeIcon: ImageIcon(
                      CustomIconsImg.menu,
                      size: 25,
                      color: CustomColors.blueSoso,
                    ),
                    icon: ImageIcon(
                      CustomIconsImg.menu,
                      size: 25,
                      color: CustomColors.iconsColorBNB,
                    ),
                    label: TextsConst.collections),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.mic,
                    color: CustomColors.white,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  activeIcon: ImageIcon(
                    CustomIconsImg.list,
                    size: 25,
                    color: CustomColors.blueSoso,
                  ),
                  icon: ImageIcon(
                    CustomIconsImg.list,
                    size: 25,
                    color: CustomColors.iconsColorBNB,
                  ),
                  label: TextsConst.audiofiles,
                ),
                BottomNavigationBarItem(
                  activeIcon: ImageIcon(
                    CustomIconsImg.profile,
                    size: 25,
                    color: CustomColors.blueSoso,
                  ),
                  icon: ImageIcon(
                    CustomIconsImg.profile,
                    size: 25,
                    color: CustomColors.iconsColorBNB,
                  ),
                  label: TextsConst.profile,
                ),
              ],
              currentIndex: state.currentIndex,
              selectedItemColor: CustomColors.blueSoso,
              unselectedItemColor: CustomColors.black,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              onTap: (int index) {
                if (state.currentIndex != index &&
                    !_sound.recorder.isRecording) {
                  _sound.url = null;
                  _sound.soundIndex = 0;
                  context
                      .read<NavigationBloc>()
                      .add(ChangeCurrentIndexEvent(currentIndex: index));
                }
              },
              selectedLabelStyle: const TextStyle(fontSize: 10),
              unselectedLabelStyle: const TextStyle(fontSize: 10),
            ),
          ),
        );
      },
    );
  }
}
