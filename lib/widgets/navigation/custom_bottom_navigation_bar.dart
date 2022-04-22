import 'package:audiotales/services/audioService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/bloc/sound_bloc.dart';
import '../../bloc/navigation_bloc/navigation_bloc.dart';
import '../../utils/consts/custom_colors.dart';
import '../../utils/consts/custom_icons_img.dart';
import '../../utils/consts/texts_consts.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);
  // const CustomBottomNavigationBar({
  //   Key? key,
  //   required this.currentIndex,
  //   required this.onSelect,
  // }) : super(key: key);

  // final int currentIndex;
  // final void Function(int) onSelect;

//   }

  @override
  Widget build(BuildContext context) {
    // final NavigationBloc navigationBloc = context.read<NavigationBloc>();
    // SoundService sound = context.read<SoundBloc>().sound;
    List<AssetImage> mic = [
      CustomIconsImg.mic,
      CustomIconsImg.mic2,
      CustomIconsImg.mic3
    ];
    return BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
      return Container(
        foregroundDecoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.center,
            image: state.soundIndex < 3 ? mic[state.soundIndex] : mic[2],
            // image: mic[state.soundIndex],
            fit: BoxFit.fitHeight,
          ),
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                color: CustomColors.boxShadow,
                //  Color.fromRGBO(0, 0, 0, 0.15),
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
                    //  Color.fromRGBO(140, 132, 226, 1),
                  ),
                  icon: ImageIcon(
                    CustomIconsImg.home,
                    size: 25,
                    color: CustomColors.iconsColorBNB,
                    // Color.fromRGBO(58, 58, 85, 0.8),
                  ),
                  label: TextsConst.head),
              BottomNavigationBarItem(
                  backgroundColor: Colors.green,
                  activeIcon: ImageIcon(
                    CustomIconsImg.menu,
                    size: 25,
                    color: CustomColors.blueSoso,
                    //  Color.fromRGBO(140, 132, 226, 1),
                  ),
                  icon: ImageIcon(
                    CustomIconsImg.menu,
                    size: 25,
                    color: CustomColors.iconsColorBNB,
                    // Color.fromRGBO(58, 58, 85, 0.8),
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
                  //  Color.fromRGBO(140, 132, 226, 1),
                ),
                icon: ImageIcon(
                  CustomIconsImg.list,
                  size: 25,
                  color: CustomColors.iconsColorBNB,
                  // Color.fromRGBO(58, 58, 85, 0.8),
                ),
                label: TextsConst.audiofiles,
              ),
              BottomNavigationBarItem(
                activeIcon: ImageIcon(
                  CustomIconsImg.profile,
                  size: 25,
                  color: CustomColors.blueSoso,
                  //  Color.fromRGBO(140, 132, 226, 1),
                ),
                icon: ImageIcon(
                  CustomIconsImg.profile,
                  size: 25,
                  color: CustomColors.iconsColorBNB,
                  // Color.fromRGBO(58, 58, 85, 0.8),
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
              if (state.currentIndex != index) {
                context
                    .read<NavigationBloc>()
                    .add(ChangeCurrentIndexEvent(currentIndex: index));
              }
              // if (index == 2 && state.currentIndex != index) {
              //   context.read<SoundBloc>().add(StartRecordEvent());
              //   // state.sound.record();
              // }
            },
            selectedLabelStyle: const TextStyle(fontSize: 10),
            unselectedLabelStyle: const TextStyle(fontSize: 10),
          ),
        ),
      );
    });
  }
}
