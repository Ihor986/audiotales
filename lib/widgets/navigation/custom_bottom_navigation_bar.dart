import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/navigation_bloc/navigation_bloc.dart';
import '../../utils/consts/colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);
  // const CustomBottomNavigationBar({
  //   Key? key,
  //   required this.currentIndex,
  //   required this.onSelect,
  // }) : super(key: key);

  // final int currentIndex;
  // final void Function(int) onSelect;

  @override
  Widget build(BuildContext context) {
    // final NavigationBloc navigationBloc = context.read<NavigationBloc>();

    return BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
      return Container(
        foregroundDecoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.center,
            image: state.currentIndex == 2
                ? const AssetImage("assets/icons/mic-2.png")
                : const AssetImage("assets/icons/mic.png"),
            fit: BoxFit.fitHeight,
          ),
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.15),
                spreadRadius: 3,
                blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                  activeIcon: ImageIcon(
                    AssetImage("assets/icons/home.png"),
                    size: 25,
                    color: Color.fromRGBO(140, 132, 226, 1),
                  ),
                  icon: ImageIcon(
                    AssetImage("assets/icons/home.png"),
                    size: 25,
                    color: Color.fromRGBO(58, 58, 85, 0.8),
                  ),
                  label: 'Главная '),
              BottomNavigationBarItem(
                  backgroundColor: Colors.green,
                  activeIcon: ImageIcon(
                    AssetImage("assets/icons/menu.png"),
                    size: 25,
                    color: Color.fromRGBO(140, 132, 226, 1),
                  ),
                  icon: ImageIcon(
                    AssetImage("assets/icons/menu.png"),
                    size: 25,
                    color: Color.fromRGBO(58, 58, 85, 0.8),
                  ),
                  label: 'Подбoрки'),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.mic,
                  color: Colors.white,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                activeIcon: ImageIcon(
                  AssetImage("assets/icons/list.png"),
                  size: 25,
                  color: Color.fromRGBO(140, 132, 226, 1),
                ),
                icon: ImageIcon(
                  AssetImage("assets/icons/list.png"),
                  size: 25,
                  color: Color.fromRGBO(58, 58, 85, 0.8),
                ),
                label: 'Аудиозаписи',
              ),
              BottomNavigationBarItem(
                activeIcon: ImageIcon(
                  AssetImage("assets/icons/profile.png"),
                  size: 25,
                  color: Color.fromRGBO(140, 132, 226, 1),
                ),
                icon: ImageIcon(
                  AssetImage("assets/icons/profile.png"),
                  size: 25,
                  color: Color.fromRGBO(58, 58, 85, 0.8),
                ),
                label: 'Профиль',
              ),
            ],
            currentIndex: state.currentIndex,
            selectedItemColor: blueSoso,
            unselectedItemColor: black,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            onTap: (int index) {
              if (state.currentIndex != index) {
                context
                    .read<NavigationBloc>()
                    .add(ChangeCurrentIndexEvent(currentIndex: index));
              }
            },
            selectedLabelStyle: const TextStyle(fontSize: 10),
            unselectedLabelStyle: const TextStyle(fontSize: 10),
          ),
        ),
      );
    });
  }
}
