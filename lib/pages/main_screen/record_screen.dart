import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/sound_bloc/sound_bloc.dart';
import '../../utils/consts/custom_colors.dart';
import '../../widgets/uncategorized/custom_clipper_widget.dart';
import '../../widgets/record_draggable_widgets/record_draggable_widget.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({Key? key}) : super(key: key);
  static const routeName = '/record_screen.dart';

  @override
  Widget build(BuildContext context) {
    num screenHeight = MediaQuery.of(context).size.height;

    return MultiBlocProvider(
        providers: [
          BlocProvider<SoundBloc>(create: (context) => SoundBloc()),
        ],
        child: Stack(
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
        ));
  }
}
