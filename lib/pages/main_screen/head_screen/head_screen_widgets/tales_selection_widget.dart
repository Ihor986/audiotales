import 'package:flutter/material.dart';
import '../../../../utils/consts/custom_colors.dart';
import 'tales_selection_widgets/add_selection_button.dart';
import '../../../../widgets/texts/main_screen_text.dart';

class TalesSelectionWidget extends StatelessWidget {
  const TalesSelectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 47),
      child: SizedBox(
        width: screen.width,
        height: screen.height * 0.25,
        // color: Colors.black12,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: CustomColors.oliveSosoOp,
              ),
              width: screen.width * 0.45,
              height: screen.height * 0.27,
              child: Column(children: const [
                SelectionText3(),
                AddSelectionButton(),
              ], mainAxisAlignment: MainAxisAlignment.center),
            ),
            Column(children: [
              Container(
                width: screen.width * 0.45,
                height: screen.height * 0.115,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromRGBO(241, 180, 136, 0.85),
                ),
                child: const SelectionText4(),
              ),
              Container(
                width: screen.width * 0.45,
                height: screen.height * 0.115,
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
