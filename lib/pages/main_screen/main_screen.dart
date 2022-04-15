import 'package:flutter/material.dart';

import '../../utils/consts/colors.dart';
import '../../widgets/buttons/main_screen_buttons/selection_buttons.dart';
import '../../widgets/navigation/custom_bottom_navigation_bar.dart';
import '../../widgets/navigation/custom_drawer.dart';
import '../../widgets/uncategorized/audio_draggable_widget.dart';
import '../../widgets/uncategorized/custom_clipper_widget.dart';
import '../../widgets/uncategorized/tales_selection_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const routeName = '/main_screen.dart';

  @override
  Widget build(BuildContext context) {
    num screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: blueSoso,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              ClipPath(
                clipper: OvalBC(),
                child: Container(
                  height: screenHeight / 4.5,
                  color: blueSoso,
                  // child: const TalesSelectionWidget(),
                ),
              ),
              // const Text('test'),
            ],
          ),
          const SelectionButtons(),
          const TalesSelectionWidget(),
          const AudioDraggableWidget(),
        ],
      ),
      drawer: const CustomDrawer(),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: const CustomBottomNavigationBar(),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Color.fromRGBO(241, 180, 136, 0),
      //   onPressed: () {},
      //   child: ImageIcon(
      //     AssetImage("assets/icons/Frame 133.png"),
      //     // size: 80,
      //     color: Color.fromRGBO(241, 180, 136, 1),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: SizedBox(
      //   height: 90,
      //   child: ClipRRect(
      //     borderRadius: const BorderRadius.only(
      //       topLeft: Radius.circular(20),
      //       topRight: Radius.circular(20),
      //     ),
      //     child: BottomAppBar(
      //       color: const Color.fromRGBO(255, 255, 255, 1),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
      //         children: [
      //           Column(
      //             children: [
      //               IconButton(
      //                 onPressed: () {},
      //                 icon: const ImageIcon(
      //                   AssetImage("assets/icons/home.png"),
      //                   size: 25,
      //                   color: Color.fromRGBO(140, 132, 226, 1),
      //                 ),
      //               )
      //             ],
      //           ),
      //           Column(
      //             children: [
      //               IconButton(
      //                 onPressed: () {},
      //                 icon: const ImageIcon(
      //                   AssetImage("assets/icons/menu.png"),
      //                   size: 25,
      //                   color: Color.fromRGBO(140, 132, 226, 1),
      //                 ),
      //               )
      //             ],
      //           ),
      //           Column(
      //             children: [
      //               IconButton(
      //                 iconSize: 40,
      //                 onPressed: () {},
      //                 icon: const ImageIcon(
      //                   AssetImage("assets/icons/Frame 133.png"),
      //                   // size: 170,
      //                   color: Color.fromRGBO(241, 180, 136, 1),
      //                 ),
      //               )
      //             ],
      //           ),
      //           Column(
      //             children: [
      //               IconButton(
      //                 onPressed: () {},
      //                 icon: const ImageIcon(
      //                   AssetImage("assets/icons/list.png"),
      //                   size: 25,
      //                   color: Color.fromRGBO(140, 132, 226, 1),
      //                 ),
      //               )
      //             ],
      //           ),
      //           Column(
      //             children: [
      //               IconButton(
      //                 onPressed: () {},
      //                 icon: const ImageIcon(
      //                   AssetImage("assets/icons/profile.png"),
      //                   size: 25,
      //                   color: Color.fromRGBO(140, 132, 226, 1),
      //                 ),
      //               )
      //             ],
      //           )
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
