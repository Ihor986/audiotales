part of 'navigation_bloc.dart';

// @immutable
// abstract class NavigationState {}

class NavigationState {
  NavigationState({required this.currentIndex, this.soundIndex = 0});

  int currentIndex;
  int soundIndex;
}
