import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'subscribe_event.dart';
part 'subscribe_state.dart';

class SubscribeBloc extends Bloc<SubscribeEvent, SubscribeState> {
  SubscribeBloc() : super(SubscribeState()) {
    on<ChangeCheckEvent>((event, emit) {
      emit(
        SubscribeState(checkIndex: event.index),
      );
    });
  }
}
