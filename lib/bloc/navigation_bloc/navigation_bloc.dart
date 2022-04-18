import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState(currentIndex: 0)) {
    on<ChangeCurrentIndexEvent>((event, emit) {
      emit(NavigationState(currentIndex: event.currentIndex));
    });
  }
}
