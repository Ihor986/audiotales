import 'package:bloc/bloc.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState()) {
    on<ChangeCurrentIndexEvent>((event, emit) {
      emit(NavigationState(currentIndex: event.currentIndex));
    });
    on<StartRecordNavEvent>((event, emit) {
      emit(NavigationState(currentIndex: 2));
    });
  }
}
