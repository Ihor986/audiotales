import 'package:audiotales/pages/subscribe_screen/widgets/subscribe_text_widget.dart';
import 'package:flutter/material.dart';
import '../../../utils/consts/custom_colors.dart';
import '../../../widgets/uncategorized/custom_clipper_widget.dart';

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
          alignment: Alignment(0, -0.15),
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
      height: screen.height * 0.65,
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
    );
  }
}
