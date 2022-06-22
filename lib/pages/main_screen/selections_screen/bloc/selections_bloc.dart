import 'package:audiotales/models/tales_list.dart';
import 'package:bloc/bloc.dart';
import '../../../../models/audio.dart';
import '../../../../models/selections.dart';
import '../../../../services/change_selection_service.dart';
import '../../../../services/select_selections_service.dart';

part 'selections_event.dart';
part 'selections_state.dart';

class SelectionsBloc extends Bloc<SelectionsEvent, SelectionsState> {
  final ChangeSelectionService changeSelectionService =
      ChangeSelectionService();
  final SelectSelectionsService selectSelectionsService =
      SelectSelectionsService();
  SelectionsBloc() : super(SelectionsState()) {
    on<CreateNewSelectonEvent>((event, emit) {
      changeSelectionService.dispouse();
      changeSelectionService.readOnly = false;
      emit(SelectionsState());
    });
    on<EditAllSelection>(
      (event, emit) {
        changeSelectionService.dispouse();
        changeSelectionService.name = event.selection.name;
        changeSelectionService.description = event.selection.description;
        changeSelectionService.photo = event.selection.photo;
        changeSelectionService.photoUrl = event.selection.photoUrl;
        changeSelectionService.readOnly = false;
        emit(SelectionsState());
      },
    );
    on<CheckEvent>((event, emit) {
      String? searchValue = state.searchValue;
      changeSelectionService.checkEvent(event.isChecked, event.id);
      // changeSelectionService.readOnly = false;
      emit(SelectionsState(searchValue: searchValue));
    });

    on<ChangeSelectionNameEvent>(
      (event, emit) {
        changeSelectionService.name = event.value;
      },
    );

    on<ChangeSelectionDescriptionEvent>(
      (event, emit) {
        changeSelectionService.description = event.value;
      },
    );

    on<SaveCreatedSelectionEvent>(
      (event, emit) async {
        await changeSelectionService.saveCreatedSelectionEvent(
            talesList: event.talesList, selectionsList: event.selectionsList);
        changeSelectionService.readOnly = false;

        emit(SelectionsState());
      },
    );

    on<SaveChangedSelectionEvent>(
      (event, emit) async {
        final Selection _selection = event.selection;
        _selection.updateDate =
            DateTime.now().millisecondsSinceEpoch.toString();
        print('!!!!!!!!!!!');
        await changeSelectionService.saveChangedSelectionEvent(
          // talesList: event.talesList,
          selectionsList: event.selectionsList,
          selection: _selection,
        );
        changeSelectionService.readOnly = true;
        emit(SelectionsState());
      },
    );

    on<SearchAudioToAddInSelectionEvent>(
      (event, emit) {
        // changeSelectionService.readOnly = false;
        emit(SelectionsState(
          searchValue: event.value,
        ));
      },
    );

    on<SelectSelectionsEvent>(
      (event, emit) {
        selectSelectionsService.dispose();
        selectSelectionsService.audio = event.audio;
        selectSelectionsService.selectionsIdList
            .addAll(event.audio.compilationsId);
        selectSelectionsService.readOnly = false;
        emit(SelectionsState(
          readOnly: selectSelectionsService.readOnly,
        ));
      },
    );

    on<CheckSelectionEvent>(
      (event, emit) {
        selectSelectionsService.changeIDList(event.id);
        selectSelectionsService.readOnly = false;
        emit(SelectionsState(
          readOnly: selectSelectionsService.readOnly,
        ));
      },
    );

    on<SaveAudioWithSelectionsListEvent>(
      (event, emit) async {
        await selectSelectionsService.addSelectionsToAudio(
          fullTalesList: event.talesList,
        );
        emit(SelectionsState());
      },
    );
  }
}
