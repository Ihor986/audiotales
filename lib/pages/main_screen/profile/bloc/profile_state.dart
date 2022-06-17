part of 'profile_bloc.dart';

class ProfileInitialState {
  ProfileInitialState({
    this.isEditing = false,
    this.isProgress = false,
    this.isDelete = false,
  });
  final bool isProgress;
  final bool isEditing;
  final bool isDelete;
}
