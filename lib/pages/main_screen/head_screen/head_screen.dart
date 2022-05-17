import 'package:flutter/material.dart';

import '../../../utils/consts/custom_colors.dart';
import 'head_screen_text.dart';
import 'selection_buttons.dart';
import 'audio_draggable_widget.dart';
import '../../../widgets/uncategorized/custom_clipper_widget.dart';
import 'tales_selection_widget.dart';

class HeadScreen extends StatelessWidget {
  const HeadScreen({Key? key}) : super(key: key);
  static const routeName = '/head_screen.dart';
  static const HeadText title = HeadText();
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    // print('${RepositoryProvider.of<UserRepository>(context).localUser.id}');

    return
        // Scaffold(
        //   extendBody: true,
        //   appBar: AppBar(
        //     backgroundColor: blueSoso,
        //     elevation: 0,
        //   ),
        //   body:
        Stack(
      children: [
        Column(
          children: [
            ClipPath(
              clipper: OvalBC(),
              child: Container(
                height: screen.height / 4.5,
                color: CustomColors.blueSoso,
                // child: const TalesSelectionWidget(),
              ),
            ),
            // const Text('test'),
          ],
        ),
        const SelectionButtons(),
        const TalesSelectionWidget(),
        const AudioDraggableWidget(),
      ],
    );
  }
}
