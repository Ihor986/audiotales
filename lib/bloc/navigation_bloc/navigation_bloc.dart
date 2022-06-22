import 'package:bloc/bloc.dart';

import '../../services/navigation_servise.dart';
import '../../services/sound_service.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  final SoundService sound = SoundService.instance;
  final NavigationService navigationService = NavigationService();
  NavigationBloc() : super(NavigationState()) {
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
