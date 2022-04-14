import 'package:flutter/material.dart';

import '../../custom_icons_icons.dart';
import '../../utils/consts/colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          // backgroundColor: Color.fromRGBO(8, 8, 8, 1),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  CustomIcons.home,
                ),
                label: 'Главная '),
            BottomNavigationBarItem(
                icon: Icon(CustomIcons.menu), label: 'Подбoрки'),
            BottomNavigationBarItem(
              // backgroundColor: Color.fromRGBO(241, 180, 136, 1),
              icon: Icon(
                Icons.mic,
                // color: Colors.white,
              ),
              label: 'Запись',
            ),
            BottomNavigationBarItem(
              icon: Icon(CustomIcons.list),
              label: 'Аудиозаписи',
            ),
            BottomNavigationBarItem(
              icon: Icon(CustomIcons.profile),
              label: 'Профиль',
            ),
          ],
          currentIndex: 1,
          selectedItemColor: blueSoso,
          unselectedItemColor: black,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: (int index) {},
          selectedLabelStyle: TextStyle(fontSize: 10),
          unselectedLabelStyle: TextStyle(fontSize: 10),
        ),
      ),
    );
  }
}
