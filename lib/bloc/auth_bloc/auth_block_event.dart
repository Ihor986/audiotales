part of 'auth_block_bloc.dart';

@immutable
abstract class AuthBlockEvent {}

class ContinueButtonEvent extends AuthBlockEvent {}

class ContinueButtonPhoneEvent extends AuthBlockEvent {}

class ContinueButtonCodeEvent extends AuthBlockEvent {}
