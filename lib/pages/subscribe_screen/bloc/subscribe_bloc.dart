import 'package:audiotales/data_base/data_base.dart';
import 'package:audiotales/models/user.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

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
        int month = DateTime.now().month;
        int year = DateTime.now().year;

        if (index == 0) {
          month++;
          _user.changeUserFields(
              nSubscribe: "${month.toString()}.${year.toString()}");
        }
        if (index == 1) {
          year++;
          _user.changeUserFields(
              nSubscribe: "${month.toString()}.${year.toString()}");
        }
        DataBase.instance.saveUser(_user);
        emit(
          SubscribeState(checkIndex: index),
        );
      },
    );
  }
}
