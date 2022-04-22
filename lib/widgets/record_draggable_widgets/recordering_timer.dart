import 'package:flutter/material.dart';
import '../../utils/consts/custom_colors.dart';
import '../../utils/consts/custom_icons_img.dart';

class RecorderingTimer extends StatelessWidget {
  const RecorderingTimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    num screenWidth = MediaQuery.of(context).size.width;
    String recorderTime = '00:00:00';

    // return BlocBuilder<SoundBloc, SoundInitial>(builder: (context, state) {
    // print(state.sound.recorderTime);
    return Align(
        alignment: const Alignment(0, 0.3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageIcon(
              CustomIconsImg.ellipseRad,
              color: CustomColors.rad,
              size: screenWidth * 0.02,
            ),
            SizedBox(
              width: screenWidth * 0.02,
            ),
            Text(recorderTime),
          ],
        ));
    // );

    // });
  }
}
