import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/sound_bloc/sound_bloc.dart';
import '../../services/audio_service.dart';
import 'play_record.dart';
import 'recordering.dart';

class RecordDraggableWidget extends StatelessWidget {
  const RecordDraggableWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SoundBloc, SoundInitial>(
      builder: (context, state) {
        SoundService sound = context.read<SoundBloc>().sound;

        return sound.url == null ? const Recordering() : const PlayRecord();
      },
    );
  }
}
