import 'package:flutter/material.dart';

import '../../utils/consts/colors.dart';
import '../../widgets/buttons/main_screen_buttons/selection_buttons.dart';
import '../../widgets/uncategorized/audio_draggable_widget.dart';
import '../../widgets/uncategorized/custom_clipper_widget.dart';
import '../../widgets/uncategorized/tales_selection_widget.dart';

class HeadScreen extends StatelessWidget {
  const HeadScreen({Key? key}) : super(key: key);
  static const routeName = '/head_screen.dart';

  @override
  Widget build(BuildContext context) {
    num screenHeight = MediaQuery.of(context).size.height;

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
                height: screenHeight / 4.5,
                color: blueSoso,
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
      // ),
      //   drawer: const CustomDrawer(),
      //   resizeToAvoidBottomInset: false,
      //   bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}