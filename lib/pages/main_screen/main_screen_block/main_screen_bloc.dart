import 'package:bloc/bloc.dart';
import '../../../data_base/data_base.dart';
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
        String? searchValue = state.searchValue;
        sound.clickPlayer(event.audio);
        emit(MainScreenState(searchValue: searchValue));
      },
    );
    on<Rewind15Event>(
      (event, emit) {
        sound.forwardPlayer(event.time);
        emit(MainScreenState());
      },
    );
    on<RemoveToDeleteAudioEvent>(
      (event, emit) async {
        TalesList _talesList = event.talesList;
        _talesList.removeAudioToDeleted(id: event.id);
        await DataBase.instance.saveAudioTales(_talesList);
        emit(MainScreenState());
      },
    );

    on<SearchAudioEvent>(
      (event, emit) {
        emit(MainScreenState(searchValue: event.value));
      },
    );

    on<DeleteUnsavedAudioEvent>(
      (event, emit) async {
        await sound.deleteUnsavedAudio();
        // emit(SoundInitial(indexPage: 0));
      },
    );
  }
}
