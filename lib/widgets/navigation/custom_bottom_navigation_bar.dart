import 'package:flutter/material.dart';
import '../../utils/consts/colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int currentIndex = 1;
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
        child: Stack(
          children: [
            BottomNavigationBar(
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
                  activeIcon: Image(
                    image: AssetImage("assets/icons/mic.png"),
                    height: 25,
                    color: Color.fromRGBO(241, 180, 136, 1),
                  ),
                  icon: Image(
                    image: AssetImage("assets/icons/Frame 133.png"),
                    height: 25,
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
              currentIndex: currentIndex,
              // iconSize: 25,
              selectedItemColor: blueSoso,
              unselectedItemColor: black,
              showSelectedLabels: currentIndex == 2 ? false : true,
              showUnselectedLabels: true,
              onTap: (int index) {
                print('object');
              },
              selectedLabelStyle: const TextStyle(fontSize: 10),
              unselectedLabelStyle: const TextStyle(fontSize: 10),
            ),
            Container(
              // height: 100,
              width: 400,
              child: IconButton(
                iconSize: 75,
                onPressed: () {},
                icon: const Image(
                  image: AssetImage("assets/icons/Frame 133.png"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
