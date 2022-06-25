import 'package:audiotales/models/tales_list.dart';
import 'package:bloc/bloc.dart';
import '../../../../models/audio.dart';
import '../../../../models/user.dart';
import '../../../../services/change_audio_servise.dart';
import '../../../../services/sound_service.dart';
part 'sound_event.dart';
part 'sound_state.dart';

class SoundBloc extends Bloc<SoundEvent, SoundInitial> {
  final SoundService sound = SoundService.instance;
  final ChangeAudioServise changeAudioServise = ChangeAudioServise();
  SoundBloc() : super(SoundInitial()) {
    on<StartRecordEvent>(
      (event, emit) async {
        await sound.clickRecorder();
        emit(SoundInitial());
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
        // sound.dispouse();
        // await sound.stopRecorder();
        emit(SoundInitial());
      },
    );

    on<SetStateEvent>(
      (event, emit) async {
        emit(SoundInitial());
      },
    );

    on<ChangeAudioNameEvent>(
      (event, emit) {
        changeAudioServise.dispose();
        changeAudioServise.name = event.audio.name;
        emit(SoundInitial(
          readOnly: false,
          chahgedAudioId: event.audio.id,
        ));
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
