import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'selections_event.dart';
part 'selections_state.dart';

class SelectionsBloc extends Bloc<SelectionsEvent, SelectionsState> {
  SelectionsBloc() : super(SelectionsInitial()) {
    on<SelectionsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
