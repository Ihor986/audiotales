import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/selections.dart';
import '../../../repositorys/selections_repositiry.dart';
import '../../../utils/consts/custom_colors.dart';
import '../../../utils/consts/custom_icons_img.dart';
import '../../../widgets/uncategorized/custom_clipper_widget.dart';
import 'add_new_selection/add_new_selection_screen.dart';
import 'bloc/selections_bloc.dart';
import 'selection_screen.dart/selection_screen.dart';
import 'selections_text.dart';

class SelectionsScreen extends StatelessWidget {
  const SelectionsScreen({Key? key}) : super(key: key);
  static const routeName = '/selections_screen.dart';
  static const SelectionsText title = SelectionsText();
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    // print('${RepositoryProvider.of<UserRepository>(context).localUser.id}');

    return Scaffold(
      extendBody: true,
      appBar: _appBar(screen, title, context),
      body: Stack(
        children: [
          Column(
            children: [
              ClipPath(
                clipper: OvalBC(),
                child: Container(
                  height: screen.height / 4.5,
                  color: CustomColors.oliveSoso,
                ),
              ),
            ],
          ),
          const Align(
              alignment: Alignment(0, -0.6), child: _WrapSelectionsList()),
        ],
      ),
    );
  }
}

AppBar _appBar(screen, title, context) {
  final SelectionsBloc _selectionsBloc =
      BlocProvider.of<SelectionsBloc>(context);
  return AppBar(
    actions: <Widget>[
      Padding(
        padding: EdgeInsets.only(right: screen.width * 0.04),
        child: Column(
          children: [
            IconButton(
              icon: const ImageIcon(CustomIconsImg.moreHorizRounded),
              // tooltip: 'Open shopping cart',
              onPressed: () {},
            ),
            const SizedBox(),
          ],
        ),
      ),
    ],
    backgroundColor: CustomColors.oliveSoso,
    centerTitle: true,
    elevation: 0,
    title: title,
    leading: Padding(
      padding: EdgeInsets.only(
        left: screen.width * 0.04,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: ImageIcon(
              CustomIconsImg.plusPlus,
              color: CustomColors.white,
              size: screen.width * 0.06,
            ),
            onPressed: () {
              _selectionsBloc.add(CreateNewSelectonEvent());
              Navigator.pushNamed(context, AddNewSelectionScreen.routeName);
            },
          ),
          const SizedBox(),
        ],
      ),
    ),
  );
}

class _WrapSelectionsList extends StatelessWidget {
  const _WrapSelectionsList({Key? key}) : super(key: key);

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
            _Selection(selection: selection),
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

class _Selection extends StatelessWidget {
  const _Selection({
    Key? key,
    required this.selection,
  }) : super(key: key);
  final Selection selection;
  @override
  Widget build(BuildContext context) {
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
            image: NetworkImage(selection.photoUrl ?? ''),
            fit: BoxFit.cover,
          );
        } catch (e) {
          return null;
        }
      }
      return null;
    }

    return GestureDetector(
      onTap: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => SelectionScreen(
              selection: selection,
            ),
          ),
          (_) => true,
        );
        // Navigator.pushNamed(
        //   context,
        //   SelectionScreen.routeName,
        // );
        // print('tap');
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
}
