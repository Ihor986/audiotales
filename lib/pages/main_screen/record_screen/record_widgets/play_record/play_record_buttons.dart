import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../utils/consts/custom_colors.dart';
import '../../../../../utils/consts/custom_icons.dart';
import '../../../../../utils/consts/custom_img.dart';
import '../../../main_screen_block/main_screen_bloc.dart';
import '../../sound_bloc/sound_bloc.dart';

class PlayRecordButtons extends StatelessWidget {
  const PlayRecordButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    final SoundBloc _record = BlocProvider.of<SoundBloc>(context);
    final MainScreenBloc _player = BlocProvider.of<MainScreenBloc>(context);
    return Container(
      width: screen.width * 1,
      foregroundDecoration: const BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.center,
          image: CustomImg.play,
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Align(
        alignment: const Alignment(0, -0.75),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                _player.add(Rewind15Event(-15));
              },
              icon: SvgPicture.asset(
                CustomIconsImg.minus15,
                // color: CustomColors.black,
              ),
              //  const ImageIcon(
              //   CustomIconsImg.minus15,
              //   size: 25,
              // ),
            ),
            IconButton(
              onPressed: () async {
                _record.add(StartRecordEvent());
              },
              icon: const Icon(Icons.pause, color: CustomColors.invisible),
            ),
            IconButton(
              onPressed: () {
                _player.add(Rewind15Event(15));
              },
              icon: SvgPicture.asset(
                CustomIconsImg.plus15,
                // color: CustomColors.black,
              ),

              //  const ImageIcon(
              //   CustomIconsImg.plus15,
              //   size: 25,
              // ),
            ),
          ],
        ),
      ),
      height: screen.height * 0.25,
    );
  }
}
