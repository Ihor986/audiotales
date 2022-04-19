import 'package:bloc/bloc.dart';

import '../../services/audioService.dart';
// import 'package:meta/meta.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  // final SoundService sound = SoundService();
  NavigationBloc() : super(NavigationState(currentIndex: 0, soundIndex: 0)) {
    on<ChangeCurrentIndexEvent>((event, emit) {
      emit(NavigationState(currentIndex: event.currentIndex, soundIndex: 0));
    });
    on<StartRecordEvent>((event, emit) async {
      // await sound.record();
      // emit(NavigationState(currentIndex: 2));
    });
    on<StopRecordEvent>((event, emit) async {
      // await sound.stopRecorder();
      emit(NavigationState(currentIndex: 2, soundIndex: 0));
    });
  }
}
