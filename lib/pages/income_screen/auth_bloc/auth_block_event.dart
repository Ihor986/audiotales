part of 'auth_block_bloc.dart';

@immutable
abstract class AuthBlockEvent {}

class ContinueButtonEvent extends AuthBlockEvent {}

class ContinueButtonPhoneEvent extends AuthBlockEvent {}

class ContinueButtonCodeEvent extends AuthBlockEvent {
  ContinueButtonCodeEvent(
      {required this.auth, required this.user, required this.talesList});
  final AuthReposytory auth;
  final LocalUser user;
  final TalesList talesList;
}
