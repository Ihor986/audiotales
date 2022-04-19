part of 'navigation_bloc.dart';

// @immutable
// abstract class NavigationState {}

class NavigationState {
  NavigationState({required this.currentIndex, required this.soundIndex});

  int currentIndex;
  int soundIndex;
}
