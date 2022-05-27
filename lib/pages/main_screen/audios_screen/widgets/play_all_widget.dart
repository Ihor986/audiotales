import 'package:audiotales/utils/consts/custom_colors.dart';
import 'package:audiotales/utils/consts/custom_icons_img.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlayAllTalesButtonWidget extends StatefulWidget {
  const PlayAllTalesButtonWidget({Key? key}) : super(key: key);

  @override
  State<PlayAllTalesButtonWidget> createState() =>
      _PlayAllTalesButtonWidgetState();
}

class _PlayAllTalesButtonWidgetState extends State<PlayAllTalesButtonWidget> {
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: screen.width * 0.54,
          decoration: BoxDecoration(
            color: isActive
                ? CustomColors.playAllButtonActiveRepeat
                : CustomColors.playAllButtonDisactiveRepeat,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      isActive = !isActive;
                    });
                  },
                  icon: SvgPicture.asset(CustomIconsImg.repeat)),
              // icon: const ImageIcon(CustomIconsImg.arrowLeftCircle)),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            width: screen.width * 0.41,
            decoration: BoxDecoration(
              color: CustomColors.white,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
      ],
    );
  }
}
