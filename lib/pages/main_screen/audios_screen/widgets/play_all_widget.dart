import 'package:audiotales/utils/consts/custom_colors.dart';
import 'package:audiotales/utils/consts/custom_icons_img.dart';
import 'package:flutter/material.dart';

class PlayAllTalesButtonWidget extends StatelessWidget {
  const PlayAllTalesButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: screen.width * 0.54,
          decoration: BoxDecoration(
            color: CustomColors.playAllButtonActiveRepeat,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {},
                  // icon: SvgPicture.asset(),
                  icon: const ImageIcon(CustomIconsImg.arrowLeftCircle)),
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
