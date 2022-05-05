import 'package:bloc/bloc.dart';

import '../../services/audio_service.dart';

part 'main_screen_event.dart';
part 'main_screen_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  final SoundService sound = SoundService();
  MainScreenBloc() : super(MainScreenState()) {
    on<ClickPlayEvent>((event, emit) {
      sound.clickPlayer(event.path);
      emit(MainScreenState());
    });
  }
}
