import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../services/audioService.dart';

part 'sound_event.dart';
part 'sound_state.dart';

class SoundBloc extends Bloc<SoundEvent, SoundState> {
  final SoundService sound = SoundService();
  SoundBloc() : super(SoundInitial()) {
    on<StartRecordEvent>((event, emit) async {
      // sound.soundIndex = 1;
      await sound.clickRecorder();
      emit(SoundInitial());
      // Timer(const Duration(seconds: 10), () async {
      // if (false) {
      //   await sound.stopRecorder();
      //   sound.recorder.closeRecorder();
      //   sound.audioPlayer.stopPlayer();
      //   sound.audioPlayer.closePlayer();
      //   sound.soundIndex = 2;
      //    emit(SoundInitial());
      // }
      // });
    });
    // on<StopRecordEvent>((event, emit) async {
    //   await sound.clickRecorder();
    //   // sound.soundIndex = 2;
    //   emit(SoundInitial());
    // });
  }
}
