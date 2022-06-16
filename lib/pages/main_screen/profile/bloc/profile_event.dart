part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class ProfileEditingEvent extends ProfileEvent {
  ProfileEditingEvent({required this.newName, required this.user});
  final LocalUser user;
  final String newName;
}

class SaveEditingEvent extends ProfileEvent {
  SaveEditingEvent({required this.user});
  final LocalUser user;
}

class SaveChangedPhoneEvent extends ProfileEvent {
  // SaveChangedPhoneEvent({required this.user});
  // final LocalUser user;
}

class SaveEditingWithPhoneEvent extends ProfileEvent {
  SaveEditingWithPhoneEvent({required this.user});
  final LocalUser user;
}

class ChangeNameEvent extends ProfileEvent {
  ChangeNameEvent({required this.newName});
  final String newName;
}

class ChangePhoneEvent extends ProfileEvent {
  ChangePhoneEvent({required this.newPhone, required this.user});
  final String newPhone;
  final LocalUser user;
}

class ChangeCodeEvent extends ProfileEvent {
  ChangeCodeEvent({required this.code});
  final String code;
}
