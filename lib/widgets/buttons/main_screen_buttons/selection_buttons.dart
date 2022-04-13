import 'package:flutter/material.dart';

import '../../../utils/consts/colors.dart';
import '../../texts/main_screen_text.dart';

class SelectionButtons extends StatelessWidget {
  const SelectionButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // num screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
        color: blueSoso,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(onPressed: () {}, child: const SelectionText1()),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                TextButton(onPressed: () {}, child: const SelectionText2()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
