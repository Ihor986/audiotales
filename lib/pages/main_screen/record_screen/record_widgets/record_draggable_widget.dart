import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../services/audio_service.dart';
import '../sound_bloc/sound_bloc.dart';
import 'play_record/play_record.dart';
import 'recordering/recordering.dart';
import 'save_record/save_record.dart';

class RecordDraggableWidget extends StatelessWidget {
  const RecordDraggableWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SoundBloc _soundBloc = BlocProvider.of<SoundBloc>(context);
    final List<Widget> pages = [
      Recordering(
        soundBloc: _soundBloc,
      ),
      const PlayRecord(),
      const SaveRecord(),
      // const SaveRecord(),
      // const SaveRecord(),
    ];
    return BlocBuilder<SoundBloc, SoundInitial>(
      builder: (context, state) {
        // int index;
        // if(.isRecoderReady){}
        return pages[_soundBloc.sound.soundIndex];

        // return SaveRecord();
      },
    );
  }
}
