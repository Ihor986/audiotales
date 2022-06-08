import 'package:audiotales/utils/consts/custom_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../bloc/navigation_bloc/navigation_bloc.dart';
import '../../../pages/income_screen/new_user/registration_page.dart';
import '../../../pages/main_screen/main_screen_block/main_screen_bloc.dart';
import '../../../services/sound_service.dart';
import '../../../utils/consts/custom_icons_img.dart';
import '../../../utils/consts/texts_consts.dart';
import 'drawer_text.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return FractionallySizedBox(
      widthFactor: 0.66,
      // heightFactor: screen.height,
      child: Container(
        height: screen.height,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.horizontal(
                left: Radius.zero, right: Radius.circular(50)),
            color: CustomColors.white),
        child: Stack(
          children: const [
            Align(alignment: Alignment(0, -0.8), child: _Header()),
            Align(alignment: Alignment(0, 0.2), child: _BodyMenu()),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return SizedBox(
      height: screen.height * 0.15,
      child: const Center(child: HeaderText()),
    );
  }
}

class _BodyMenu extends StatelessWidget {
  const _BodyMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SoundService _sound = BlocProvider.of<MainScreenBloc>(context).sound;
    Size screen = MediaQuery.of(context).size;
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Container(
          // color: Colors.amberAccent,
          height: screen.height * 0.55,
          child: Column(
            children: [
              _MenuButtonRow(
                text: TextsConst.head,
                onClick: () {
                  if (state.pageIndex != 0 && !_sound.recorder.isRecording) {
                    _sound.url = null;
                    _sound.soundIndex = 0;
                    context
                        .read<NavigationBloc>()
                        .add(ChangeCurrentIndexEvent(currentIndex: 0));
                  }
                  Scaffold.of(context).openEndDrawer();
                },
                icon: CustomIconsImg.home,
              ),
              _MenuButtonRow(
                text: TextsConst.profile,
                onClick: () {
                  final FirebaseAuth auth = FirebaseAuth.instance;
                  if (auth.currentUser == null) {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamedAndRemoveUntil(
                      RegistrationPage.routeName,
                      (_) => false,
                    );
                  } else if (state.pageIndex != 4 &&
                      !_sound.recorder.isRecording) {
                    _sound.url = null;
                    _sound.soundIndex = 0;
                    context
                        .read<NavigationBloc>()
                        .add(ChangeCurrentIndexEvent(currentIndex: 4));
                  }
                  Scaffold.of(context).openEndDrawer();
                },
                icon: CustomIconsImg.profile,
              ),
              _MenuButtonRow(
                text: TextsConst.collections,
                onClick: () {
                  if (state.pageIndex != 1 && !_sound.recorder.isRecording) {
                    _sound.url = null;
                    _sound.soundIndex = 0;
                    context
                        .read<NavigationBloc>()
                        .add(ChangeCurrentIndexEvent(currentIndex: 1));
                  }
                  Scaffold.of(context).openEndDrawer();
                },
                icon: CustomIconsImg.menu,
              ),
              _MenuButtonRow(
                text: TextsConst.allAudioFiles,
                onClick: () {
                  if (state.pageIndex != 3 && !_sound.recorder.isRecording) {
                    _sound.url = null;
                    _sound.soundIndex = 0;
                    context
                        .read<NavigationBloc>()
                        .add(ChangeCurrentIndexEvent(currentIndex: 3));
                  }
                  Scaffold.of(context).openEndDrawer();
                },
                icon: CustomIconsImg.list,
              ),
              _MenuButtonRow(
                text: TextsConst.search,
                onClick: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: CustomIconsImg.search,
              ),
              _MenuButtonRow(
                text: TextsConst.deletedDrower,
                onClick: () {
                  if (state.pageIndex != 5 && !_sound.recorder.isRecording) {
                    _sound.url = null;
                    _sound.soundIndex = 0;
                    context
                        .read<NavigationBloc>()
                        .add(ChangeCurrentIndexEvent(currentIndex: 5));
                  }
                  Scaffold.of(context).openEndDrawer();
                },
                icon: CustomIconsImg.delete,
              ),
              SizedBox(
                height: screen.height * 0.04,
              ),
              _MenuButtonRow(
                text: TextsConst.subscribe,
                onClick: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: CustomIconsImg.wallet,
              ),
              SizedBox(
                height: screen.height * 0.04,
              ),
              _MenuButtonRow(
                text: TextsConst.support,
                textTwo: TextsConst.supportTwo,
                onClick: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: CustomIconsImg.support,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MenuButtonRow extends StatelessWidget {
  const _MenuButtonRow({
    Key? key,
    required this.icon,
    required this.text,
    required this.onClick,
    this.textTwo,
  }) : super(key: key);
  final String icon;
  final String text;
  final String? textTwo;
  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return ElevatedButton(
      style: ButtonStyle(
        shadowColor: MaterialStateProperty.all(
          CustomColors.white,
        ),
        backgroundColor: MaterialStateProperty.all(
          CustomColors.white,
        ),
        overlayColor: MaterialStateProperty.all(
          CustomColors.noTalesText,
        ),
        elevation: MaterialStateProperty.all(
          0.0,
        ),
      ),
      onPressed: onClick,
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            height: screen.height * 0.03,
            color: CustomColors.black,
          ),
          textTwo == null
              ? BodyText(text: text)
              : DuobleBodyText(text: text, textTwo: textTwo ?? ''),
        ],
      ),
    );
  }
}
