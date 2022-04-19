part of 'navigation_bloc.dart';

abstract class NavigationEvent {}

class ChangeCurrentIndexEvent extends NavigationEvent {
  ChangeCurrentIndexEvent({
    required this.currentIndex,
  });

  int currentIndex;
} //

class StartRecordEvent extends NavigationEvent {}

class StopRecordEvent extends NavigationEvent {}//
