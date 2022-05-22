import 'package:audiotales/utils/consts/custom_colors.dart';
import 'package:flutter/material.dart';

class WrapSelectionsList extends StatelessWidget {
  const WrapSelectionsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    List<Widget> selections = [
      _selection(screen),
      _selection(screen),
      _selection(screen),
      _selection(screen),
      _selection(screen),
      _selection(screen),
      _selection(screen),
      _selection(screen),
      _selection(screen),
      // _selection(screen),
      // _selection(screen),
      // _selection(screen),
    ];
    return SizedBox(
      // color: Colors.amber,
      height: screen.height * 0.75,
      child: SingleChildScrollView(
        child: Wrap(
          direction: Axis.horizontal,
          children: [
            for (var selection in selections)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: selection,
              )
          ],
        ),
      ),
    );
  }
}

_selection(Size screen) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: CustomColors.boxShadow,
    ),
    width: screen.width * 0.45,
    height: screen.height * 0.27,
    child: Column(children: const [
      // SelectionText3(),
      // AddSelectionButton(),
    ], mainAxisAlignment: MainAxisAlignment.center),
  );
}
