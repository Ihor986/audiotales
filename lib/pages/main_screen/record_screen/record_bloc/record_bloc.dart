import 'package:audiotales/models/tales_list.dart';
import 'package:bloc/bloc.dart';
import '../../../../models/user.dart';
import '../../../../services/sound_service.dart';
part 'record_event.dart';
part 'record_state.dart';

class RecordBloc extends Bloc<RecordEvent, RecordState> {
  RecordBloc() : super(RecordState()) {
    on<StartRecordEvent>(
      (event, emit) async {
        await sound.clickRecorder();
        emit(RecordState());
      },
    );
    on<SaveRecordEvent>(
      (event, emit) async {
        emit(RecordState(isProgress: true));
        await sound.saveAudioTale(
          fullTalesList: event.talesListRep,
          localUser: event.localUser,
          isAutosaveLocal: event.isAutosaveLocal,
        );
        sound.soundIndex = 2;
        emit(RecordState());
      },
    );
    on<SetStateEvent>(
      (event, emit) async {
        emit(RecordState());
      },
    );
  }
  final SoundService sound = SoundService.instance;
}
