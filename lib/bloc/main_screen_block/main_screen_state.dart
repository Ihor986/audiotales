part of 'main_screen_bloc.dart';

class MainScreenState {
  MainScreenState({
    this.searchValue,
    this.readOnly = true,
    this.chahgedAudioId,
  });

  final bool readOnly;
  final String? chahgedAudioId;
  String? searchValue;
}
