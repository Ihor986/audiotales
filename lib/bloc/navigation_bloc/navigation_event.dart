part of 'navigation_bloc.dart';

abstract class NavigationEvent {}

class ChangeCurrentIndexEvent extends NavigationEvent {
  ChangeCurrentIndexEvent({
    required this.currentIndex,
  });

  int currentIndex;
} //

class StartRecordNavEvent extends NavigationEvent {
  StartRecordNavEvent({required this.soundIndex});
  int soundIndex;
}

// class StopRecordEvent extends NavigationEvent {}//
