import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../models/selections.dart';
import '../../../../repositorys/selections_repositiry.dart';
import '../../../../utils/consts/custom_colors.dart';
import '../../selections_screen/selections_text.dart';
import 'tales_selection_widgets/add_selection_button.dart';
import '../../../../widgets/texts/main_screen_text.dart';

class TalesSelectionWidget extends StatelessWidget {
  const TalesSelectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    final List<Selection> _selectionsList =
        RepositoryProvider.of<SelectionsListRepository>(context)
            .getSelectionsListRepository()
            .selectionsList;
    return Padding(
      padding: const EdgeInsets.only(top: 47),
      child: SizedBox(
        width: screen.width,
        height: screen.height * 0.25,
        // color: Colors.black12,
        child: Row(
          children: [
            _selectionsList.length > 2
                ? _selection(
                    context: context,
                    selection: _selectionsList[2],
                    width: 0.45,
                    height: 0.27)
                : Container(
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
              _selectionsList.length > 1
                  ? _selection(
                      context: context,
                      selection: _selectionsList[1],
                      width: 0.45,
                      height: 0.115)
                  : Container(
                      width: screen.width * 0.45,
                      height: screen.height * 0.115,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromRGBO(241, 180, 136, 0.85),
                      ),
                      child: const SelectionText4(),
                    ),
              _selectionsList.isNotEmpty
                  ? _selection(
                      context: context,
                      selection: _selectionsList[0],
                      width: 0.45,
                      height: 0.115)
                  : Container(
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

Widget _selection({
  required BuildContext context,
  required Selection selection,
  required double width,
  required double height,
}) {
  Size screen = MediaQuery.of(context).size;
  DecorationImage? decorationImage() {
    if (selection.photo != null) {
      try {
        return DecorationImage(
            image: MemoryImage(File(selection.photo ?? '').readAsBytesSync()),
            fit: BoxFit.cover);
      } catch (_) {}
    }

    if (selection.photoUrl != null) {
      try {
        return DecorationImage(
            image: NetworkImage(selection.photoUrl ?? ''), fit: BoxFit.cover);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  return GestureDetector(
    onTap: () {
      print('tap');
    },
    child: Container(
      decoration: BoxDecoration(
        image: decorationImage(),
        borderRadius: BorderRadius.circular(15),
        color: CustomColors.iconsColorBNB,
      ),
      width: screen.width * width,
      height: screen.height * height,
      child: Padding(
        padding: EdgeInsets.all(screen.width * 0.04),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            WrapSelectionsListTextName(selection: selection),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: WrapSelectionsListTextData(selection: selection),
            ),
          ],
        ),
      ),
    ),
  );
}
