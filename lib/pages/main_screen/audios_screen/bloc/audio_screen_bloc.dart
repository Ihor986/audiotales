import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../models/audio.dart';
import '../../../../services/sound_service.dart';

part 'audio_screen_event.dart';
part 'audio_screen_state.dart';

class AudioScreenBloc extends Bloc<AudioScreenEvent, AudioScreenState> {
  final SoundService sound;
  AudioScreenBloc(this.sound)
      : super(
          AudioScreenState(),
        ) {
    on<AudioScreenPlayAllEvent>(
      (event, emit) async {
        await sound.playAllPlayer(event.talesList);

        emit(AudioScreenState());
      },
    );

    on<AudioScreenChangeRepeatEvent>(
      (event, emit) {
        sound.isRepeatAllList = !sound.isRepeatAllList;

        emit(AudioScreenState());
      },
    );

    // on<DeleteAudioEvent>(
    //   (event, emit) async {
    //     TalesList _talesList = event.talesList;
    //     _talesList.deleteAudio(id: event.id);
    //     await DataBase.instance.saveAudioTales(_talesList);
    //     emit(AudioScreenState());
    //   },
    // );
  }
}
