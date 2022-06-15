import 'package:audiotales/pages/subscribe_screen/widgets/subscribe_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../utils/consts/custom_colors.dart';
import '../../../widgets/uncategorized/custom_clipper_widget.dart';
import '../../utils/consts/custom_icons_img.dart';
import '../../utils/consts/texts_consts.dart';
import 'bloc/subscribe_bloc.dart';

class SubscribeScreen extends StatelessWidget {
  const SubscribeScreen({Key? key}) : super(key: key);
  static const routeName = '/record_screen.dart';
  static const SubscribeScreenTitleText title = SubscribeScreenTitleText();

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
                height: screen.height / 4.5,
                color: CustomColors.blueSoso,
              ),
            ),
          ],
        ),
        const Align(
          alignment: Alignment(0, -0.45),
          child: CardWidget(),
        ),
      ],
    );
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    return Container(
      height: screen.height * 0.7,
      width: screen.width * 0.97,
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
      child: Stack(children: [
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
      ]),
    );
    //   },
    // );
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
        Size screen = MediaQuery.of(context).size;

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
            width: screen.width * 0.44,
            height: screen.height * 0.27,
            child: Padding(
              padding: EdgeInsets.all(screen.width * 0.04),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),
                  text[index],
                  const Spacer(flex: 1),
                  state.checkIndex == index
                      ? SvgPicture.asset(
                          CustomIconsImg.check,
                          height: screen.height * 0.055,
                          color: CustomColors.black,
                        )
                      : SvgPicture.asset(
                          CustomIconsImg.uncheck,
                          height: screen.height * 0.055,
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
    Size screen = MediaQuery.of(context).size;
    return Column(
      children: [
        Text(
          TextsConst.monthCoast,
          style: TextStyle(
            fontSize: screen.height * 0.024,
            color: CustomColors.black,
          ),
        ),
        SizedBox(
          height: screen.height * 0.009,
        ),
        Text(
          TextsConst.monthCoast2,
          style: TextStyle(
            fontSize: screen.height * 0.018,
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
    Size screen = MediaQuery.of(context).size;
    return Column(
      children: [
        Text(
          TextsConst.yearCoast,
          style: TextStyle(
            fontSize: screen.height * 0.024,
            color: CustomColors.black,
          ),
        ),
        SizedBox(
          height: screen.height * 0.009,
        ),
        Text(
          TextsConst.yearCoast2,
          style: TextStyle(
            fontSize: screen.height * 0.018,
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
    Size screen = MediaQuery.of(context).size;
    return SizedBox(
      height: screen.height * 0.1,
      child: Center(
        child: Text(
          TextsConst.selectNotyfi,
          style: TextStyle(
            fontSize: screen.height * 0.027,
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
    Size screen = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
        left: screen.width * 0.1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                TextsConst.whatDoesTheSubscriptionGive,
                style: TextStyle(
                  fontSize: screen.height * 0.022,
                  color: CustomColors.black,
                ),
              ),
            ],
          ),
          SizedBox(
            height: screen.height * 0.02,
          ),
          Row(
            children: [
              SvgPicture.asset(
                CustomIconsImg.vector,
                height: screen.height * 0.015,
                color: CustomColors.black,
              ),
              SizedBox(
                width: screen.width * 0.025,
              ),
              Text(
                TextsConst.unlimitedMemory,
                style: TextStyle(
                  fontSize: screen.height * 0.015,
                  color: CustomColors.black,
                ),
              ),
            ],
          ),
          SizedBox(
            height: screen.height * 0.01,
          ),
          Row(
            children: [
              SvgPicture.asset(
                CustomIconsImg.cloud,
                height: screen.height * 0.015,
                color: CustomColors.black,
              ),
              SizedBox(
                width: screen.width * 0.025,
              ),
              Text(
                TextsConst.allFilesAreStoredInTheCloud,
                style: TextStyle(
                  fontSize: screen.height * 0.015,
                  color: CustomColors.black,
                ),
              ),
            ],
          ),
          SizedBox(
            height: screen.height * 0.01,
          ),
          Row(
            children: [
              SvgPicture.asset(
                CustomIconsImg.downloadIcon,
                height: screen.height * 0.015,
                color: CustomColors.black,
              ),
              SizedBox(
                width: screen.width * 0.025,
              ),
              Text(
                TextsConst.abilityToDownloadWithoutRestrictions,
                style: TextStyle(
                  fontSize: screen.height * 0.015,
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
    Size screen = MediaQuery.of(context).size;
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: screen.height * 0.05,
          ),
          ElevatedButton(
            onPressed: () {},
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
