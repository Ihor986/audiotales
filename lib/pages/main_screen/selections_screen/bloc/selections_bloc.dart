import 'package:audiotales/models/tales_list.dart';
import 'package:bloc/bloc.dart';
import '../../../../models/selections.dart';
import '../../../../services/add_audio_to_selection_service.dart';

part 'selections_event.dart';
part 'selections_state.dart';

class SelectionsBloc extends Bloc<SelectionsEvent, SelectionsState> {
  final ChangeSelectionService changeSelectionService =
      ChangeSelectionService();
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
      changeSelectionService.checkEvent(event.isChecked, event.id);
      // changeSelectionService.readOnly = false;
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
        await changeSelectionService.saveCreatedSelectionEvent(
            talesList: event.talesList, selectionsList: event.selectionsList);
        changeSelectionService.readOnly = false;
        emit(SelectionsState());
      },
    );

    on<SaveChangedSelectionEvent>(
      (event, emit) async {
        await changeSelectionService.saveChangedSelectionEvent(
          // talesList: event.talesList,
          selectionsList: event.selectionsList,
          selection: event.selection,
        );
        changeSelectionService.readOnly = true;
        emit(SelectionsState());
      },
    );

    on<SearchAudioToAddInSelectionEvent>(
      (event, emit) {
        changeSelectionService.readOnly = false;
        emit(SelectionsState(
          searchValue: event.value,
        ));
      },
    );
  }
}
