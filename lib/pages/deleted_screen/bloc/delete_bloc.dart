import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data_base/data_base.dart';
import '../../../models/tales_list.dart';

part 'delete_event.dart';
part 'delete_state.dart';

class DeleteBloc extends Bloc<DeleteEvent, DeleteState> {
  DeleteBloc() : super(DeleteState()) {
    on<DeleteAudioEvent>(
      (event, emit) async {
        await DataBase.instance
            .deleteAudioTaleFromDB(event.id, event.talesList);
        emit(DeleteState());
      },
    );
  }
}
