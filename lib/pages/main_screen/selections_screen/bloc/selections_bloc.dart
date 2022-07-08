import 'package:audiotales/data_base/data_base.dart';
import 'package:audiotales/models/tales_list.dart';
import 'package:bloc/bloc.dart';
import '../../../../models/audio.dart';
import '../../../../models/selections.dart';
import '../../../../services/change_selection_service.dart';
import '../../../../services/select_selections_service.dart';

part 'selections_event.dart';
part 'selections_state.dart';

class SelectionsBloc extends Bloc<SelectionsEvent, SelectionsState> {
  SelectionsBloc() : super(SelectionsState()) {
    on<DisposeEvent>((event, emit) {
      selectSelectionsService.dispose();
      emit(SelectionsState());
    });

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
      changeSelectionService.checkEvent(event.isChecked, event.id);
    });

    on<UncheckAll>((event, emit) {
      changeSelectionService.dispouse();
      emit(SelectionsState());
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
        emit(SelectionsState(isProgress: true));
        await changeSelectionService.saveCreatedSelectionEvent(
            talesList: event.talesList, selectionsList: event.selectionsList);
        changeSelectionService.readOnly = false;

        emit(SelectionsState());
      },
    );

    on<SaveChangedSelectionEvent>(
      (event, emit) async {
        emit(SelectionsState(isProgress: true));
        final Selection _selection = event.selection;
        _selection.updateDate =
            DateTime.now().millisecondsSinceEpoch.toString();
        await changeSelectionService.saveChangedSelectionEvent(
          selectionsList: event.selectionsList,
          selection: _selection,
        );
        changeSelectionService.readOnly = true;
        emit(SelectionsState());
      },
    );

    on<SearchAudioToAddInSelectionEvent>(
      (event, emit) {
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

    on<SelectSelectionsForListAudiosEvent>(
      (event, emit) {
        selectSelectionsService.dispose();
        selectSelectionsService.audioList = changeSelectionService.checkedList;
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
        emit(SelectionsState(isProgress: true));
        await selectSelectionsService.addSelections(
          fullTalesList: event.talesList,
        );
        emit(SelectionsState());
      },
    );

    on<RemoveFromSelectionEvent>(
      (event, emit) async {
        emit(SelectionsState(isProgress: true));
        final TalesList _talesList = event.talesList;
        final List<String>? _audioList = event.audio == null
            ? changeSelectionService.checkedList
            : [event.audio!.id];
        if (_audioList == null || _audioList == []) return;
        _talesList.removeAudiosFromSelections(
            idList: _audioList, selectionId: event.selectionId);
        await DataBase.instance.saveAudioTales(_talesList);
        emit(SelectionsState());
      },
    );

    on<DeleteSelectionEvent>(
      (event, emit) async {
        emit(SelectionsState(isProgress: true));
        final SelectionsList selectionsList = event.selectionsList;
        final TalesList talesList = event.talesList;
        talesList.deleteSelectionFromAudio(event.selection);
        selectionsList.deleteSelection(selection: event.selection);
        await DataBase.instance.saveSelectionsList(selectionsList);
        await DataBase.instance.saveAudioTales(talesList);
        emit(SelectionsState());
      },
    );
  }
  final ChangeSelectionService changeSelectionService =
      ChangeSelectionService();
  final SelectSelectionsService selectSelectionsService =
      SelectSelectionsService();
}
