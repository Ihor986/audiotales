import 'package:bloc/bloc.dart';
import '../../../models/audio.dart';
import '../../../models/tales_list.dart';
import '../../../services/sound_service.dart';

part 'main_screen_event.dart';
part 'main_screen_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  final SoundService sound = SoundService();
  MainScreenBloc() : super(MainScreenState()) {
    on<ClickPlayEvent>(
      (event, emit) {
        sound.clickPlayer(event.audio);
        emit(MainScreenState());
      },
    );
    on<Rewind15Event>(
      (event, emit) {
        sound.forwardPlayer(event.time);
        emit(MainScreenState());
      },
    );
    on<DeleteAudioEvent>(
      (event, emit) {
        sound.checkDeleteAudio(list: event.list, audio: event.audio);
        emit(MainScreenState());
      },
    );
  }
}
