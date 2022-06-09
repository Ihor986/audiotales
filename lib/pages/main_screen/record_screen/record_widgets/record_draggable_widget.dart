import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../services/audio_service.dart';
import '../sound_bloc/sound_bloc.dart';
import 'play_record/play_record.dart';
import 'recordering/recordering.dart';
import 'save_record/save_record.dart';

class RecordDraggableWidget extends StatelessWidget {
  RecordDraggableWidget({Key? key}) : super(key: key);

  final List<Widget> pages = [
    const Recordering(),
    const PlayRecord(),
    const SaveRecord(),
    // const SaveRecord(),
    // const SaveRecord(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SoundBloc, SoundInitial>(
      builder: (context, state) {
        // int index;
        // if(.isRecoderReady){}
        return pages[context.read<SoundBloc>().sound.soundIndex];

        // return SaveRecord();
      },
    );
  }
}
