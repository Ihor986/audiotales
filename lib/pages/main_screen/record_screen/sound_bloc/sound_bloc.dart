import 'package:audiotales/models/tales_list.dart';
import 'package:bloc/bloc.dart';
import '../../../../models/user.dart';
import '../../../../services/sound_service.dart';
part 'sound_event.dart';
part 'sound_state.dart';

class SoundBloc extends Bloc<SoundEvent, SoundInitial> {
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
    on<SetStateEvent>(
      (event, emit) async {
        emit(SoundInitial());
      },
    );
  }
  final SoundService sound = SoundService.instance;
}
