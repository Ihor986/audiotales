import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../models/audio.dart';
import '../../../../services/sound_service.dart';

part 'audio_screen_event.dart';
part 'audio_screen_state.dart';

class AudioScreenBloc extends Bloc<AudioScreenEvent, AudioScreenState> {
  final SoundService sound = SoundService.instance;
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
