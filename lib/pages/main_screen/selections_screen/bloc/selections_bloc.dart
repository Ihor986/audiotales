import 'package:audiotales/data_base/data_base.dart';
import 'package:audiotales/models/tales_list.dart';
import 'package:bloc/bloc.dart';

import '../../../../services/add_audio_to_selection_service.dart';

part 'selections_event.dart';
part 'selections_state.dart';

class SelectionsBloc extends Bloc<SelectionsEvent, SelectionsState> {
  final AddAudioToSelectionService addAudioToSelectionService =
      AddAudioToSelectionService();
  SelectionsBloc() : super(SelectionsState()) {
    on<CreateNewSelectonEvent>((event, emit) {
      addAudioToSelectionService.checkedList = [];
      emit(SelectionsState());
    });
    on<CheckEvent>((event, emit) {
      addAudioToSelectionService.checkEvent(event.isChecked, event.id);
      emit(SelectionsState());
    });
    on<SaveCreatedSelectionEvent>(
      (event, emit) {
        String _selectionId = DateTime.now().millisecondsSinceEpoch.toString();
        TalesList _talesList = event.talesList;

        for (String id in addAudioToSelectionService.checkedList) {
          _talesList.fullTalesList.map(
            (element) {
              if (element.id == id) {
                element.compilationsId.add(_selectionId);
              }
              return element;
            },
          ).toList();
        }

        DataBase.instance.saveAudioTales(_talesList);
        addAudioToSelectionService.checkedList = [];
      },
    );
  }
}
