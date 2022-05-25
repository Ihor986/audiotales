import 'package:audiotales/data_base/data_base.dart';
import 'package:audiotales/models/tales_list.dart';
import 'package:bloc/bloc.dart';

import '../../../../models/selections.dart';
import '../../../../services/add_audio_to_selection_service.dart';

part 'selections_event.dart';
part 'selections_state.dart';

class SelectionsBloc extends Bloc<SelectionsEvent, SelectionsState> {
  final AddAudioToSelectionService addAudioToSelectionService =
      AddAudioToSelectionService();
  SelectionsBloc() : super(SelectionsState()) {
    on<CreateNewSelectonEvent>((event, emit) {
      addAudioToSelectionService.dispouse();
      emit(SelectionsState());
    });
    on<CheckEvent>((event, emit) {
      addAudioToSelectionService.checkEvent(event.isChecked, event.id);
      emit(SelectionsState());
    });
    on<SaveCreatedSelectionEvent>(
      (event, emit) {
        addAudioToSelectionService.saveCreatedSelectionEvent(
            talesList: event.talesList, selectionsList: event.selectionsList);
      },
    );
    on<CreateSelectionNameEvent>((event, emit) {
      addAudioToSelectionService.name = event.value;
      emit(SelectionsState());
    });
  }
}
