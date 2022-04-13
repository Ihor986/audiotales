import 'package:flutter/material.dart';

import '../../utils/consts/colors.dart';
import '../../widgets/buttons/main_screen_buttons/selection_buttons.dart';
import '../../widgets/navigation/custom_drawer.dart';
import '../../widgets/uncategorized/audio_draggable_widget.dart';
import '../../widgets/uncategorized/custom_clipper_widget.dart';
import '../../widgets/uncategorized/tales_selection_widget.dart';
import '../new_user/new_user.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const routeName = '/head_screen.dart';

  @override
  Widget build(BuildContext context) {
    num screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
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
        bottomNavigationBar: Container(
          foregroundDecoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.15),
                    spreadRadius: 2,
                    blurRadius: 10)
              ],
              color: Color.fromRGBO(246, 246, 246, 1),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: BottomNavigationBar(
            backgroundColor: const Color.fromRGBO(246, 246, 246, 0),
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.mobile_friendly), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.abc_sharp), label: ''),
            ],
          ),
        ));
  }
}
