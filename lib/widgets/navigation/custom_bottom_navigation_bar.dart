import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../bloc/navigation_bloc/navigation_bloc.dart';
import '../../pages/main_screen/main_screen_block/main_screen_bloc.dart';
import '../../services/sound_service.dart';
import '../../utils/consts/custom_colors.dart';
import '../../utils/consts/custom_icons_img.dart';
import '../../utils/consts/texts_consts.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({
    Key? key,
    this.onTap,
  }) : super(key: key);
  final void Function(int index)? onTap;

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final SoundService _sound = BlocProvider.of<MainScreenBloc>(context).sound;
    // final FirebaseAuth auth = FirebaseAuth.instance;
    Size screen = MediaQuery.of(context).size;
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        bool isIconActive = state.pageIndex < 5;
        return Container(
          height: screen.height * 0.107,
          foregroundDecoration: BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.center,
              image: state.pageIndex == 2
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
              items: [
                BottomNavigationBarItem(
                    activeIcon: SvgPicture.asset(
                      CustomIconsImg.home,
                      height: 25,
                      color: isIconActive
                          ? CustomColors.blueSoso
                          : CustomColors.iconsColorBNB,
                    ),
                    icon: SvgPicture.asset(
                      CustomIconsImg.home,
                      height: 25,
                      color: CustomColors.iconsColorBNB,
                    ),
                    label: TextsConst.head),
                BottomNavigationBarItem(
                    // backgroundColor: Colors.green,
                    activeIcon: SvgPicture.asset(
                      CustomIconsImg.menu,
                      height: 25,
                      color: isIconActive
                          ? CustomColors.blueSoso
                          : CustomColors.iconsColorBNB,
                    ),
                    icon: SvgPicture.asset(
                      CustomIconsImg.menu,
                      height: 25,
                      color: CustomColors.iconsColorBNB,
                    ),
                    label: TextsConst.collections),
                const BottomNavigationBarItem(
                  icon: Icon(
                    Icons.mic,
                    color: CustomColors.invisible,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(
                    CustomIconsImg.list,
                    height: 25,
                    color: isIconActive
                        ? CustomColors.blueSoso
                        : CustomColors.iconsColorBNB,
                  ),
                  icon: SvgPicture.asset(
                    CustomIconsImg.list,
                    height: 25,
                    color: CustomColors.iconsColorBNB,
                  ),
                  label: TextsConst.audiofiles,
                ),
                BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(
                    CustomIconsImg.profile,
                    height: 25,
                    color: isIconActive
                        ? CustomColors.blueSoso
                        : CustomColors.iconsColorBNB,
                  ),
                  icon: SvgPicture.asset(
                    CustomIconsImg.profile,
                    height: 25,
                    color: CustomColors.iconsColorBNB,
                  ),
                  label: TextsConst.profile,
                ),
              ],
              currentIndex: state.getCurentIndex(),
              selectedItemColor: isIconActive
                  ? CustomColors.blueSoso
                  : CustomColors.iconsColorBNB,
              unselectedItemColor: CustomColors.black,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              onTap: widget.onTap,
              selectedLabelStyle: const TextStyle(fontSize: 10),
              unselectedLabelStyle: const TextStyle(fontSize: 10),
            ),
          ),
        );
      },
    );
  }
}
