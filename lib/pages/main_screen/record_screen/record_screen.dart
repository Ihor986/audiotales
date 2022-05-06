import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/main_screen_block/main_screen_bloc.dart';
import '../../../bloc/sound_bloc/sound_bloc.dart';
import '../../../services/audio_service.dart';
import '../../../utils/consts/custom_colors.dart';
import '../../../widgets/uncategorized/custom_clipper_widget.dart';
import '../../../widgets/record_draggable_widgets/record_draggable_widget.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({Key? key}) : super(key: key);
  static const routeName = '/record_screen.dart';

  @override
  Widget build(BuildContext context) {
    num screenHeight = MediaQuery.of(context).size.height;
    final SoundService _sound = BlocProvider.of<MainScreenBloc>(context).sound;
    _sound.initRecorder();
    return MultiBlocProvider(
      providers: [
        BlocProvider<SoundBloc>(create: (context) => SoundBloc(_sound)),
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
          RecordDraggableWidget(),
        ],
      ),
    );
  }
}
