import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/sound_bloc/sound_bloc.dart';
// import '../../services/audio_service.dart';
import 'play_record.dart';
import 'recordering.dart';
import 'save_record.dart';

class RecordDraggableWidget extends StatelessWidget {
  RecordDraggableWidget({Key? key}) : super(key: key);

  final List<Widget> pages = [
    const Recordering(),
    const PlayRecord(),
    const SaveRecord(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SoundBloc, SoundInitial>(
      builder: (context, state) {
        return pages[state.indexPage];

        // return SaveRecord();
      },
    );
  }
}
