import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/navigation_bloc/navigation_bloc.dart';
import '../../bloc/sound_bloc/sound_bloc.dart';
import '../../services/audio_service.dart';
import 'play_record.dart';
import 'recordering.dart';

class RecordDraggableWidget extends StatelessWidget {
  const RecordDraggableWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SoundBloc, SoundInitial>(builder: (context, state) {
      SoundService sound = context.read<SoundBloc>().sound;
      if (sound.soundIndex == 0) {
        context.read<SoundBloc>().add(StartRecordEvent());
        context
            .read<NavigationBloc>()
            .add(StartRecordNavEvent(soundIndex: sound.soundIndex + 1));

        // Timer(const Duration(seconds: 3), () async {
        //   context.read<SoundBloc>().add(StartRecordEvent());
        // if (sound.recordLengthLimitStart == sound.recordLengthLimitControl) {
        //   context.read<SoundBloc>().add(StartRecordEvent());
        //   context
        //       .read<NavigationBloc>()
        //       .add(StartRecordNavEvent(soundIndex: sound.soundIndex + 1));
        // }
        // });
      }
      // sound.recorder.isRecording
      //     ? print('ok')
      //     : context.read<SoundBloc>().add(StartRecordEvent());
      return sound.soundIndex < 2 ? const Recordering() : const PlayRecord();
    });
  }
}
