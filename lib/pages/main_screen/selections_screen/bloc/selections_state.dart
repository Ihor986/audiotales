part of 'selections_bloc.dart';

// @immutable
// abstract class SelectionsState {}

class SelectionsState {
  SelectionsState({
    this.searchValue,
    this.heightDescriptionInput = 0.15,
    this.maxLinesDescriptionInput = 3,
    this.readOnly = true,
    this.isProgress = false,
  });
  String? searchValue;
  double heightDescriptionInput;
  int maxLinesDescriptionInput;
  bool readOnly;
  bool isProgress;
}
