import 'package:audiotales/models/user.dart';
import 'package:audiotales/pages/subscribe_screen/widgets/subscribe_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../utils/consts/custom_colors.dart';
import '../../../widgets/uncategorized/custom_clipper_widget.dart';
import '../../bloc/navigation_bloc/navigation_bloc.dart';
import '../../repositorys/user_reposytory.dart';
import '../../utils/consts/custom_icons.dart';
import '../../utils/consts/texts_consts.dart';
import 'bloc/subscribe_bloc.dart';

class SubscribeScreen extends StatelessWidget {
  const SubscribeScreen({Key? key}) : super(key: key);
  static const routeName = '/subscribe_screen.dart';
  static const SubscribeScreenTitleText title = SubscribeScreenTitleText();

  @override
  Widget build(BuildContext context) {
    final Size _screen = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              ClipPath(
                clipper: OvalBC(),
                child: Container(
                  alignment: const Alignment(0, -0.8),
                  height: _screen.height * 0.3,
                  color: CustomColors.blueSoso,
                  child: _SubscribeScreenAppBar(
                    onAction: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
              ),
            ],
          ),
          const Align(
            alignment: Alignment(0, 0.2),
            child: _CardWidget(),
          ),
        ],
      ),
    );
  }
}

class _SubscribeScreenAppBar extends StatelessWidget {
  const _SubscribeScreenAppBar({
    Key? key,
    required this.onAction,
  }) : super(key: key);
  final void Function() onAction;

  @override
  Widget build(BuildContext context) {
    final Size _screen = MediaQuery.of(context).size;
    return Container(
      height: 0.18 * _screen.height,
      color: CustomColors.blueSoso,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 0.04 * _screen.height,
            ),
            child: Stack(
              children: [
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: SubscribeScreenTitleText(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(
                        CustomIconsImg.drawer,
                        height: 0.02 * _screen.height,
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

class _CardWidget extends StatelessWidget {
  const _CardWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final LocalUser _user =
        RepositoryProvider.of<UserRepository>(context).getLocalUser();
    final Size _screen = MediaQuery.of(context).size;
    return Container(
      height: _screen.height * 0.7,
      width: _screen.width * 0.97,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: CustomColors.boxShadow,
            spreadRadius: 3,
            blurRadius: 10,
          )
        ],
        color: CustomColors.white,
        border: Border.all(color: CustomColors.audioBorder),
        borderRadius: const BorderRadius.all(Radius.circular(41)),
      ),
      child: _user.subscribe == null
          ? Stack(children: [
              Column(
                children: [
                  const _SubscribeTextHeadre(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      _SelectSubscribe(
                        index: 0,
                      ),
                      _SelectSubscribe(
                        index: 1,
                      ),
                    ],
                  ),
                  const Spacer(flex: 1),
                  const _SubscribeText(),
                  const _SubscribeButton(),
                  const Spacer(flex: 1),
                ],
              ),
            ])
          : Stack(children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text('Подписка действует до '),
                        Text('${_user.subscribe?.substring(0, 10)}'),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [],
                  ),
                  const Spacer(flex: 1),
                  const _SubscribeText(),
                  const Spacer(flex: 1),
                ],
              ),
            ]),
    );
  }
}

class _SelectSubscribe extends StatelessWidget {
  const _SelectSubscribe({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  static const List<Widget> text = [
    _MonthCoast(),
    _YearCoast(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscribeBloc, SubscribeState>(
      buildWhen: (previous, current) {
        return previous.checkIndex != current.checkIndex;
      },
      builder: (context, state) {
        final Size _screen = MediaQuery.of(context).size;

        return GestureDetector(
          onTap: () {
            context.read<SubscribeBloc>().add(
                  ChangeCheckEvent(index: index),
                );
          },
          child: Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: CustomColors.boxShadow,
                  spreadRadius: 3,
                  blurRadius: 10,
                )
              ],
              borderRadius: BorderRadius.circular(15),
              color: CustomColors.white,
            ),
            width: _screen.width * 0.44,
            height: _screen.height * 0.27,
            child: Padding(
              padding: EdgeInsets.all(_screen.width * 0.04),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),
                  text[index],
                  const Spacer(flex: 1),
                  state.checkIndex == index
                      ? SvgPicture.asset(
                          CustomIconsImg.check,
                          height: _screen.height * 0.055,
                          color: CustomColors.black,
                        )
                      : SvgPicture.asset(
                          CustomIconsImg.uncheck,
                          height: _screen.height * 0.055,
                          color: CustomColors.black,
                        ),
                  const Spacer(flex: 1),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _MonthCoast extends StatelessWidget {
  const _MonthCoast({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _screen = MediaQuery.of(context).size;
    return Column(
      children: [
        Text(
          TextsConst.monthCoast,
          style: TextStyle(
            fontSize: _screen.height * 0.024,
            color: CustomColors.black,
          ),
        ),
        SizedBox(
          height: _screen.height * 0.009,
        ),
        Text(
          TextsConst.monthCoast2,
          style: TextStyle(
            fontSize: _screen.height * 0.018,
            color: CustomColors.black,
          ),
        ),
      ],
    );
  }
}

class _YearCoast extends StatelessWidget {
  const _YearCoast({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _screen = MediaQuery.of(context).size;
    return Column(
      children: [
        Text(
          TextsConst.yearCoast,
          style: TextStyle(
            fontSize: _screen.height * 0.024,
            color: CustomColors.black,
          ),
        ),
        SizedBox(
          height: _screen.height * 0.009,
        ),
        Text(
          TextsConst.yearCoast2,
          style: TextStyle(
            fontSize: _screen.height * 0.018,
            color: CustomColors.black,
          ),
        ),
      ],
    );
  }
}

class _SubscribeTextHeadre extends StatelessWidget {
  const _SubscribeTextHeadre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _screen = MediaQuery.of(context).size;
    return SizedBox(
      height: _screen.height * 0.1,
      child: Center(
        child: Text(
          TextsConst.selectNotyfi,
          style: TextStyle(
            fontSize: _screen.height * 0.027,
            color: CustomColors.black,
          ),
        ),
      ),
    );
  }
}

class _SubscribeText extends StatelessWidget {
  const _SubscribeText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _screen = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
        left: _screen.width * 0.1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                TextsConst.whatDoesTheSubscriptionGive,
                style: TextStyle(
                  fontSize: _screen.height * 0.022,
                  color: CustomColors.black,
                ),
              ),
            ],
          ),
          SizedBox(
            height: _screen.height * 0.02,
          ),
          Row(
            children: [
              SvgPicture.asset(
                CustomIconsImg.vector,
                height: _screen.height * 0.015,
                color: CustomColors.black,
              ),
              SizedBox(
                width: _screen.width * 0.025,
              ),
              Text(
                TextsConst.unlimitedMemory,
                style: TextStyle(
                  fontSize: _screen.height * 0.015,
                  color: CustomColors.black,
                ),
              ),
            ],
          ),
          SizedBox(
            height: _screen.height * 0.01,
          ),
          Row(
            children: [
              SvgPicture.asset(
                CustomIconsImg.cloud,
                height: _screen.height * 0.015,
                color: CustomColors.black,
              ),
              SizedBox(
                width: _screen.width * 0.025,
              ),
              Text(
                TextsConst.allFilesAreStoredInTheCloud,
                style: TextStyle(
                  fontSize: _screen.height * 0.015,
                  color: CustomColors.black,
                ),
              ),
            ],
          ),
          SizedBox(
            height: _screen.height * 0.01,
          ),
          Row(
            children: [
              SvgPicture.asset(
                CustomIconsImg.downloadIcon,
                height: _screen.height * 0.015,
                color: CustomColors.black,
              ),
              SizedBox(
                width: _screen.width * 0.025,
              ),
              Text(
                TextsConst.abilityToDownloadWithoutRestrictions,
                style: TextStyle(
                  fontSize: _screen.height * 0.015,
                  color: CustomColors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SubscribeButton extends StatelessWidget {
  const _SubscribeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _screen = MediaQuery.of(context).size;
    final LocalUser _user =
        RepositoryProvider.of<UserRepository>(context).getLocalUser();

    return Center(
      child: Column(
        children: [
          SizedBox(
            height: _screen.height * 0.05,
          ),
          ElevatedButton(
            onPressed: () {
              context
                  .read<SubscribeBloc>()
                  .add(ChangeSubscribeEvent(user: _user));
              context
                  .read<NavigationBloc>()
                  .add(ChangeCurrentIndexEvent(currentIndex: 0));
            },
            child: const Text(
              TextsConst.subscribeForMonth,
              style: TextStyle(fontSize: 18),
            ),
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(309, 59),
                primary: CustomColors.rose,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
          ),
        ],
      ),
    );
  }
}
