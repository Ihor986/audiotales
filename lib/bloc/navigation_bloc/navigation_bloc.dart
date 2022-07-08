import 'package:bloc/bloc.dart';
import '../../services/sound_service.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState()) {
    final SoundService sound = SoundService.instance;

    on<ChangeCurrentIndexEvent>((event, emit) {
      if (state.pageIndex == event.currentIndex || sound.recorder.isRecording) {
        return;
      }
      sound.dispouse();
      emit(NavigationState(pageIndex: event.currentIndex));
    });
    on<StartRecordNavEvent>((event, emit) {
      emit(NavigationState(pageIndex: 2));
    });
  }
}
