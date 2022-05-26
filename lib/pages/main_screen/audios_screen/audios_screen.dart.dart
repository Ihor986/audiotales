import 'package:flutter/material.dart';

import '../../../utils/consts/custom_colors.dart';
import '../../../widgets/uncategorized/custom_clipper_widget.dart';
import '../active_tales_list_widget.dart';
import 'widgets/audios_screen_text.dart';
import 'widgets/audios_screen_text.dart';
import 'widgets/play_all_widget.dart';

class AudiosScreen extends StatefulWidget {
  const AudiosScreen({Key? key}) : super(key: key);
  static const routeName = '/audios_screen.dart';
  static const AudiosScreenText title = AudiosScreenText();

  @override
  State<AudiosScreen> createState() => _AudiosScreen();
}

class _AudiosScreen extends State<AudiosScreen> {
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return Stack(
      children: [
        ClipPath(
          clipper: OvalBC(),
          child: Container(
            height: screen.height / 4.5,
            color: CustomColors.audiotalesHeadColorBlue,
          ),
        ),
        Align(
          alignment: const Alignment(1, -0.8),
          child: SizedBox(
            height: screen.height * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                AudiosScreenListTextData(),
                PlayAllTalesButtonWidget(),
              ],
            ),
          ),
        ),
        Align(
            alignment: const Alignment(0, 1),
            child: SizedBox(
                height: screen.height * 0.65,
                child: const ActiveTalesListWidget())),
      ],
    );
  }
}
