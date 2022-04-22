import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/bloc/sound_bloc.dart';
import '../../bloc/navigation_bloc/navigation_bloc.dart';
import '../../services/audioService.dart';
import 'play_record.dart';
import 'recordering.dart';

class RecordDraggableWidget extends StatelessWidget {
  const RecordDraggableWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SoundBloc>(
        create: (context) => SoundBloc(),
        child: BlocBuilder<SoundBloc, SoundState>(builder: (context, state) {
          SoundService sound = context.read<SoundBloc>().sound;
          if (sound.soundIndex == 0) {
            context
                .read<NavigationBloc>()
                .add(StartRecordNavEvent(soundIndex: sound.soundIndex + 1));
            context.read<SoundBloc>().add(StartRecordEvent());
            Timer(const Duration(seconds: 10), () async {
              if (sound.recordLengthLimitStart ==
                  sound.recordLengthLimitControl) {
                context
                    .read<NavigationBloc>()
                    .add(StartRecordNavEvent(soundIndex: sound.soundIndex + 1));
                context.read<SoundBloc>().add(StartRecordEvent());
              }
            });
          }
          return sound.soundIndex < 2
              ? const Recordering()
              : const PlayRecord();
        }));
  }
}
