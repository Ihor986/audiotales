import 'package:flutter/material.dart';
import '../buttons/main_screen_buttons/add_selection_button.dart';
import '../texts/main_screen_text.dart';

class TalesSelectionWidget extends StatelessWidget {
  const TalesSelectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 47),
      child: SizedBox(
        width: screenWidth,
        height: screenHeight * 0.25,
        // color: Colors.black12,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromRGBO(113, 165, 159, 0.85),
              ),
              width: screenWidth * 0.45,
              height: screenHeight * 0.27,
              child: Column(children: const [
                SelectionText3(),
                AddSelectionButton(),
              ], mainAxisAlignment: MainAxisAlignment.center),
            ),
            Column(children: [
              Container(
                width: screenWidth * 0.45,
                height: screenHeight * 0.115,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromRGBO(241, 180, 136, 0.85),
                ),
                child: const SelectionText4(),
              ),
              Container(
                width: screenWidth * 0.45,
                height: screenHeight * 0.115,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromRGBO(103, 139, 210, 0.85),
                ),
                child: const SelectionText5(),
              ),
            ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
      ),
    );
  }
}
