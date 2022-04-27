import 'package:bloc/bloc.dart';
import '../../services/audioService.dart';
part 'sound_event.dart';
part 'sound_state.dart';

class SoundBloc extends Bloc<SoundEvent, SoundInitial> {
  final SoundService sound = SoundService();

  SoundBloc() : super(SoundInitial()) {
    on<StartRecordEvent>((event, emit) async {
      await sound.clickRecorder();
      emit(SoundInitial());
    });
    on<StopRecordEvent>((event, emit) async {
      // await sound.disposeRecorder();
      // sound.soundIndex = 2;
      // emit(SoundInitial());
    });
  }
}
