import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/audioService.dart';
import '../../utils/consts/custom_colors.dart';
import '../../widgets/buttons/main_screen_buttons/selection_buttons.dart';
import '../../widgets/uncategorized/audio_draggable_widget.dart';
import '../../widgets/uncategorized/custom_clipper_widget.dart';
import '../../widgets/uncategorized/record_draggable_widget.dart';
import '../../widgets/uncategorized/tales_selection_widget.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({Key? key}) : super(key: key);
  static const routeName = '/record_screen.dart';

  @override
  Widget build(BuildContext context) {
    num screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Column(
          children: [
            ClipPath(
              clipper: OvalBC(),
              child: Container(
                height: screenHeight / 4.5,
                color: CustomColors.blueSoso,
              ),
            ),
          ],
        ),
        const RecordDraggableWidget(),
      ],
    );
  }
}
