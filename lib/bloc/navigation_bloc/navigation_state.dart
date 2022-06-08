part of 'navigation_bloc.dart';

class NavigationState {
  NavigationState({
    // this.currentIndex = 0,
    this.pageIndex = 0,
    // required this.activeSelection,
  });
//  final Selection activeSelection;
  // int currentIndex;
  int pageIndex;
  int getCurentIndex() {
    int currentIndex;
    if (pageIndex == 5) {
      currentIndex = 3;
    } else if (pageIndex > 5) {
      currentIndex = 0;
    } else {
      currentIndex = pageIndex;
    }
    return currentIndex;
  }
}
