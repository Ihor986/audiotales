import 'package:audiotales/models/tales_list.dart';
import 'package:bloc/bloc.dart';
import '../../../../data_base/data_base.dart';
import '../../../../models/audio.dart';
import '../../../../models/user.dart';
import '../../../../services/change_audio_servise.dart';
import '../../../../services/sound_service.dart';
part 'sound_event.dart';
part 'sound_state.dart';

class SoundBloc extends Bloc<SoundEvent, SoundInitial> {
  final SoundService sound;
  final ChangeAudioServise changeAudioServise = ChangeAudioServise();
  SoundBloc(this.sound) : super(SoundInitial()) {
    on<StartRecordEvent>(
      (event, emit) async {
        await sound.clickRecorder();
        emit(SoundInitial());
        // emit(SoundInitial(indexPage: sound.url == null ? 0 : 1));
      },
    );
    on<SaveRecordEvent>(
      (event, emit) async {
        emit(SoundInitial(isProgress: true));
        await sound.saveAudioTale(
          fullTalesList: event.talesListRep,
          localUser: event.localUser,
          isAutosaveLocal: event.isAutosaveLocal,
        );
        sound.soundIndex = 2;
        emit(SoundInitial());
      },
    );
    on<StopRecordEvent>(
      (event, emit) async {
        await sound.stopRecorder();
        // emit(SoundInitial(indexPage: 0));
        emit(SoundInitial());
      },
    );

    on<ChangeAudioNameEvent>(
      (event, emit) {
        changeAudioServise.dispose();
        changeAudioServise.name = event.name;
        emit(SoundInitial(readOnly: false));
      },
    );

    on<SaveChangedAudioNameEvent>(
      (event, emit) async {
        await changeAudioServise.saveChangedAudioName(
          audio: event.audio,
          fullTalesList: event.fullTalesList,
        );
        emit(SoundInitial());
      },
    );

    on<EditingAudioNameEvent>(
      (event, emit) {
        changeAudioServise.name = event.value;
      },
    );
  }
}
