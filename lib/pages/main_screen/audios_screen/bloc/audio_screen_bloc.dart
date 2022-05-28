import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../models/audio.dart';
import '../../../../services/sound_service.dart';

part 'audio_screen_event.dart';
part 'audio_screen_state.dart';

class AudioScreenBloc extends Bloc<AudioScreenEvent, AudioScreenState> {
  final SoundService sound;
  AudioScreenBloc(this.sound)
      : super(AudioScreenState(
          sound: sound,
        )) {
    on<AudioScreenPlayAllEvent>((event, emit) async {
      int soundIndex = state.soundIndex;
      bool isPlayAll = !state.isPlayAll;

      await sound.playAllPlayer(event.talesList);
      emit(AudioScreenState(
        sound: sound,
        soundIndex: soundIndex,
        isPlayAll: isPlayAll,
      ));
    });

    on<AudioScreenChangeRepeatEvent>((event, emit) {
      sound.isRepeatAllList = !sound.isRepeatAllList;
      int soundIndex = state.soundIndex;
      bool isPlayAll = state.isPlayAll;

      emit(AudioScreenState(
        sound: sound,
        soundIndex: soundIndex,
        isPlayAll: isPlayAll,
      ));
    });

    // on<AudioScreenContinueEvent>((event, emit) {
    //   int soundIndex = state.soundIndex++;
    //   bool isActive = state.isActive;
    //   bool isPlayAll = state.isPlayAll;
    //   bool isRepeat = state.isRepeat;
    //   sound.clickPlayer(event.talesList[soundIndex]);
    //   emit(AudioScreenState(
    //     sound: sound,
    //     soundIndex: soundIndex,
    //     isActive: isActive,
    //     isPlayAll: isPlayAll,
    //     isRepeat: isRepeat,
    //   ));
    // });
  }
}
