part of 'subscribe_bloc.dart';

@immutable
abstract class SubscribeEvent {}

class ChangeCheckEvent extends SubscribeEvent {
  ChangeCheckEvent({required this.index});
  final int index;
}

class ChangeSubscribeEvent extends SubscribeEvent {
  ChangeSubscribeEvent({required this.user});
  final LocalUser user;
}
