import 'dart:io';

import 'package:audiotales/utils/consts/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/selections.dart';
import '../../../repositorys/selections_repositiry.dart';
import 'bloc/selections_bloc.dart';
import 'selections_text.dart';

class WrapSelectionsList extends StatelessWidget {
  const WrapSelectionsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectionsBloc, SelectionsState>(
      builder: (context, state) {
        Size screen = MediaQuery.of(context).size;
        final List<Selection> _selectionsList =
            RepositoryProvider.of<SelectionsListRepository>(context)
                .getSelectionsListRepository()
                .selectionsList;

        List<Widget> selections = [];

        for (var selection in _selectionsList) {
          selections.add(
            _selection(context, selection),
          );
        }

        return SizedBox(
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
      },
    );
  }
}

Widget _selection(BuildContext context, Selection selection) {
  Size screen = MediaQuery.of(context).size;
  DecorationImage? decorationImage() {
    if (selection.photo != null) {
      try {
        // print(selection.photo);
        return DecorationImage(
            image: MemoryImage(File(selection.photo ?? '').readAsBytesSync()),
            fit: BoxFit.cover);
      } catch (e) {
        // print(e);
      }
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
      width: screen.width * 0.45,
      height: screen.height * 0.27,
      child: Padding(
        padding: EdgeInsets.all(screen.width * 0.04),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            WrapSelectionsListTextName(selection: selection),
            WrapSelectionsListTextData(selection: selection),
          ],
        ),
      ),
    ),
  );
}
