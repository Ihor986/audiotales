import 'package:audiotales/models/tales_list.dart';
import 'package:bloc/bloc.dart';
import '../../../../models/user.dart';
import '../../../../services/audio_service.dart';
part 'sound_event.dart';
part 'sound_state.dart';

class SoundBloc extends Bloc<SoundEvent, SoundInitial> {
  final SoundService sound;
  SoundBloc(this.sound) : super(SoundInitial(indexPage: 0)) {
    on<StartRecordEvent>(
      (event, emit) async {
        await sound.clickRecorder();
        emit(SoundInitial(indexPage: sound.url == null ? 0 : 1));
      },
    );
    on<SaveRecordEvent>(
      (event, emit) async {
        await sound.saveAudioTale(
            fullTalesList: event.talesListRep, localUser: event.localUser);
        emit(SoundInitial(indexPage: 2));
      },
    );
    on<StopRecordEvent>(
      (event, emit) async {
        await sound.stopRecorder();
        emit(SoundInitial(indexPage: 0));
      },
    );
  }
}
