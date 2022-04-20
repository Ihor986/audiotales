import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../services/audioService.dart';

part 'sound_event.dart';
part 'sound_state.dart';

class SoundBloc extends Bloc<SoundEvent, SoundState> {
  final SoundService sound = SoundService();
  SoundBloc() : super(SoundInitial()) {
    on<StartRecordEvent>((event, emit) async {
      sound.soundIndex = 1;
      await sound.clickRecorder();
      // sound.soundIndex = 1;
      emit(SoundInitial());
    });
    // on<StopRecordEvent>((event, emit) async {
    //   await sound.clickRecorder();
    //   // sound.soundIndex = 2;
    //   emit(SoundInitial());
    // });
  }
}
