import 'package:bloc/bloc.dart';

import '../../services/audioService.dart';
// import 'package:meta/meta.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  // final SoundService sound = SoundService();
  NavigationBloc() : super(NavigationState(currentIndex: 0)) {
    on<ChangeCurrentIndexEvent>((event, emit) {
      emit(NavigationState(currentIndex: event.currentIndex));
    });
    on<StartRecordNavEvent>((event, emit) {
      emit(NavigationState(currentIndex: 2, soundIndex: event.soundIndex));
    });
  }
}
