import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data_base/data_base.dart';
import '../../../models/tales_list.dart';
import '../../../services/select_audio_to_delete_service.dart';

part 'delete_event.dart';
part 'delete_state.dart';

class DeleteBloc extends Bloc<DeleteEvent, DeleteState> {
  final SelectAudioToDeleteService selectAudioToDeleteService =
      SelectAudioToDeleteService();
  DeleteBloc() : super(DeleteState()) {
    on<DeleteAudioEvent>(
      (event, emit) async {
        await DataBase.instance
            .deleteAudioTaleFromDB([event.id], event.talesList);
        emit(DeleteState());
      },
    );

    on<SelectDeletedAudioEvent>(
      (event, emit) async {
        selectAudioToDeleteService.checkedList.clear();
        selectAudioToDeleteService.isChosen =
            !selectAudioToDeleteService.isChosen;
        emit(DeleteState());
      },
    );

    on<CheckEvent>((event, emit) {
      selectAudioToDeleteService.checkEvent(event.isChecked, event.id);
      emit(DeleteState());
    });

    on<DeleteSelectedAudioEvent>((event, emit) async {
      await selectAudioToDeleteService.deleteSelectedAudioEvent(
          talesList: event.talesList);
      emit(DeleteState());
    });

    on<RestoreSelectedAudioEvent>((event, emit) {
      selectAudioToDeleteService.restoreSelectedAudioEvent(
          talesList: event.talesList);
      emit(DeleteState());
    });

    // on<DeleteOldAudioEvent>((event, emit) {
    //   selectAudioToDeleteService.deleteOldAudio(talesList: event.talesList);
    //   emit(DeleteState());
    // });
  }
}
