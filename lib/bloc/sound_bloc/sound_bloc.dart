import 'package:audiotales/models/tales_list.dart';
import 'package:bloc/bloc.dart';
import '../../services/audio_service.dart';
part 'sound_event.dart';
part 'sound_state.dart';

class SoundBloc extends Bloc<SoundEvent, SoundInitial> {
  final SoundService sound = SoundService();

  SoundBloc() : super(SoundInitial()) {
    on<StartRecordEvent>(
      (event, emit) async {
        await sound.clickRecorder();
        emit(SoundInitial());
      },
    );
    on<SaveRecordEvent>(
      (event, emit) async {
        await sound.saveAudioTale(event.talesListRep);
        print(event.talesListRep.talesList.length);
        emit(SoundInitial());
      },
    );
    on<StopRecordEvent>(
      (event, emit) async {
        await sound.disposeRecorder();
        emit(SoundInitial());
      },
    );
  }
}
