import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../models/tale.dart';
import '../../../../services/sound_service.dart';

part 'audio_screen_event.dart';
part 'audio_screen_state.dart';

class AudioScreenBloc extends Bloc<AudioScreenEvent, AudioScreenState> {
  AudioScreenBloc()
      : super(
          AudioScreenState(),
        ) {
    on<AudioScreenPlayAllEvent>(
      (event, emit) async {
        sound.idPlayingList = event.selection;
        sound.isPlayingList = true;
        await sound.play(event.talesList, indexAudio: 0);

        emit(AudioScreenState());
      },
    );

    on<AudioScreenChangeRepeatEvent>(
      (event, emit) {
        sound.isRepeatAllList = !sound.isRepeatAllList;

        emit(AudioScreenState());
      },
    );
  }
  final SoundService sound = SoundService.instance;
}
