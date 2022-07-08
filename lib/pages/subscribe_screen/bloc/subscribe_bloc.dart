import 'package:audiotales/data_base/data_base.dart';
import 'package:audiotales/models/user.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../services/minuts_text_convert_service.dart';

part 'subscribe_event.dart';
part 'subscribe_state.dart';

class SubscribeBloc extends Bloc<SubscribeEvent, SubscribeState> {
  SubscribeBloc() : super(SubscribeState()) {
    on<ChangeCheckEvent>(
      (event, emit) {
        emit(
          SubscribeState(checkIndex: event.index),
        );
      },
    );

    on<ChangeSubscribeEvent>(
      (event, emit) {
        final int index = state.checkIndex;
        final LocalUser _user = event.user;
        final List<Period> _periodList = [Period.month, Period.year];
        _user.subscribe = timeTextConvertService.dayMonthYearSubscribe(
            period: _periodList.elementAt(index));
        DataBase.instance.saveUser(_user);
        emit(
          SubscribeState(checkIndex: index),
        );
      },
    );
  }
  final TimeTextConvertService timeTextConvertService =
      TimeTextConvertService.instance;
}
