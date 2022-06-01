import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../models/audio.dart';
import '../../../../models/selections.dart';
import '../../../../repositorys/tales_list_repository.dart';
import '../../../../utils/consts/custom_colors.dart';
import '../../../../utils/consts/custom_icons_img.dart';
import '../../../../widgets/uncategorized/play_all_button.dart';
import '../../../../widgets/uncategorized/tales_list_widget.dart';
import '../../../../widgets/uncategorized/custom_clipper_widget.dart';
import '../selections_text.dart';
import 'text_selection_screen.dart';

class SelectionScreenPageArguments {
  SelectionScreenPageArguments({
    required this.selection,
  });

  final Selection selection;
}

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({
    Key? key,
    required this.selection,
  }) : super(key: key);
  static const routeName = '/selection_screen.dart';
  final Selection selection;
  @override
  Widget build(BuildContext context) {
    final List<AudioTale> talesList =
        RepositoryProvider.of<TalesListRepository>(context)
            .getTalesListRepository()
            .getCompilation(selection.id);
    Size screen = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      appBar: _appBar(context),
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
          Padding(
            padding: EdgeInsets.only(left: screen.width * 0.05),
            child: _SelectionNameInput(
              selection: selection,
            ),
          ),
          Align(
            alignment: const Alignment(0, -0.8),
            child: _SelectionPhotoWidget(
              selection: selection,
              talesList: talesList,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screen.height * 0.38,
              // color: Colors.amber,
              child: TalesListWidget(
                talesList: talesList,
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, -0.05),
            child: _SelectionDescriptionInput(
              selection: selection,
            ),
          ),
        ],
      ),
    );
  }
}

AppBar _appBar(BuildContext context) {
  const TitleSelectionScreen title = TitleSelectionScreen();
  Size screen = MediaQuery.of(context).size;

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
    leading: Padding(
      padding: EdgeInsets.only(
        top: screen.width * 0.02,
        left: screen.width * 0.04,
        bottom: screen.width * 0.02,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: CustomColors.white,
        ),
        child: IconButton(
          icon: const ImageIcon(
            CustomIconsImg.arrowLeftCircle,
            color: CustomColors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    ),
    title: title,
  );
}

class _SelectionDescriptionInput extends StatelessWidget {
  const _SelectionDescriptionInput({
    Key? key,
    required this.selection,
  }) : super(key: key);
  final Selection selection;

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return Container(
      // color: Colors.blue,
      height: screen.height * 0.15,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: screen.width * 0.04, right: screen.width * 0.04),
            child: TextFormField(
              initialValue: selection.description,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              readOnly: true,
              onChanged: (value) {},
              keyboardType: TextInputType.multiline, //
              maxLines: 4,
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectionPhotoWidget extends StatelessWidget {
  const _SelectionPhotoWidget({
    Key? key,
    required this.selection,
    required this.talesList,
  }) : super(key: key);

  final Selection selection;
  final List<AudioTale> talesList;

  @override
  Widget build(BuildContext context) {
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
            image: NetworkImage(selection.photoUrl ?? ''),
            fit: BoxFit.cover,
          );
        } catch (_) {
          return null;
        }
      }
      return null;
    }

    return Container(
      width: screen.width * 0.92,
      height: screen.height * 0.25,
      decoration: BoxDecoration(
        image: decorationImage(),
        boxShadow: const [
          BoxShadow(
              color: CustomColors.boxShadow, spreadRadius: 3, blurRadius: 10)
        ],
        color: CustomColors.whiteOp,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(screen.width * 0.04),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: screen.height * 0.05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('data'),
                  SizedBox(),
                ],
              ),
            ),
            SizedBox(
              height: screen.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  WrapSelectionsListTextData(selection: selection),
                  PlayAllTalesButtonWidget(
                    talesList: talesList,
                    textColor: CustomColors.white,
                    backgroundColor: CustomColors.playAllButtonDisactive,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectionNameInput extends StatelessWidget {
  const _SelectionNameInput({
    Key? key,
    required this.selection,
  }) : super(key: key);

  final Selection selection;

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return TextFormField(
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      initialValue: selection.name,
      onChanged: (value) {},
      readOnly: true,
      style: TextStyle(
        color: CustomColors.white,
        fontSize: screen.width * 0.055,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
