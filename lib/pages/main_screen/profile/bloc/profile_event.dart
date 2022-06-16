part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class ProfileEditingEvent extends ProfileEvent {
  ProfileEditingEvent({required this.newName});
  final String newName;
}

class SaveEditingEvent extends ProfileEvent {
  SaveEditingEvent({required this.user});
  final LocalUser user;
}

class ChangeNameEvent extends ProfileEvent {
  ChangeNameEvent({required this.newName});
  final String newName;
}

class ChangePhoneEvent extends ProfileEvent {
  ChangePhoneEvent({required this.newPhone});
  final String newPhone;
}
