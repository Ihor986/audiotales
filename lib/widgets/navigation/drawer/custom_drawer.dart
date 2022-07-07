import 'package:audiotales/utils/consts/custom_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../bloc/navigation_bloc/navigation_bloc.dart';
import '../../../pages/income_screen/new_user/registration_page.dart';
import '../../../services/mailto_service.dart';
import '../../../utils/consts/custom_icons.dart';
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
            Align(alignment: Alignment(0, -0.85), child: _Header()),
            Align(alignment: Alignment(0, 1), child: _BodyMenu()),
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
    final Size screen = MediaQuery.of(context).size;
    final FirebaseAuth auth = FirebaseAuth.instance;
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return SizedBox(
          // color: Colors.amberAccent,
          height: screen.height * 0.75,
          child: Column(
            children: [
              _MenuButtonRow(
                text: TextsConst.head,
                onClick: () {
                  context
                      .read<NavigationBloc>()
                      .add(ChangeCurrentIndexEvent(currentIndex: 0));

                  Scaffold.of(context).openEndDrawer();
                },
                icon: CustomIconsImg.home,
              ),
              _MenuButtonRow(
                text: TextsConst.profile,
                onClick: () {
                  if (auth.currentUser == null) {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamedAndRemoveUntil(
                      RegistrationPage.routeName,
                      (_) => false,
                    );
                  } else {
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
                  context
                      .read<NavigationBloc>()
                      .add(ChangeCurrentIndexEvent(currentIndex: 1));

                  Scaffold.of(context).openEndDrawer();
                },
                icon: CustomIconsImg.menu,
              ),
              _MenuButtonRow(
                text: TextsConst.allAudioFiles,
                onClick: () {
                  context
                      .read<NavigationBloc>()
                      .add(ChangeCurrentIndexEvent(currentIndex: 3));

                  Scaffold.of(context).openEndDrawer();
                },
                icon: CustomIconsImg.list,
              ),
              _MenuButtonRow(
                text: TextsConst.search,
                onClick: () {
                  context
                      .read<NavigationBloc>()
                      .add(ChangeCurrentIndexEvent(currentIndex: 5));

                  Scaffold.of(context).openEndDrawer();
                },
                icon: CustomIconsImg.search,
              ),
              _MenuButtonRow(
                text: TextsConst.deletedDrower,
                onClick: () {
                  context
                      .read<NavigationBloc>()
                      .add(ChangeCurrentIndexEvent(currentIndex: 6));

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
                  if (auth.currentUser == null) {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamedAndRemoveUntil(
                      RegistrationPage.routeName,
                      (_) => false,
                    );
                  } else {
                    context
                        .read<NavigationBloc>()
                        .add(ChangeCurrentIndexEvent(currentIndex: 7));
                  }

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
                  MailToService.instance.forwardToEMail();
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
            height: screen.height * 0.025,
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
