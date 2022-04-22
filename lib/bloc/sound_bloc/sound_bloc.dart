import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../services/audioService.dart';

part 'sound_event.dart';
part 'sound_state.dart';

class SoundBloc extends Bloc<SoundEvent, SoundInitial> {
  final SoundService sound = SoundService();
  SoundBloc() : super(SoundInitial(SoundService())) {
    on<StartRecordEvent>((event, emit) async {
      await sound.clickRecorder();
      emit(SoundInitial(sound));
    });
    // on<StopRecordEvent>((event, emit) async {
    //   await sound.clickRecorder();
    //   // sound.soundIndex = 2;
    //   emit(SoundInitial());
    // });
  }
}
