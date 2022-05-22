import 'package:flutter/material.dart';

import '../../../../utils/consts/custom_colors.dart';
import '../../../../utils/consts/custom_icons_img.dart';
import '../../../../widgets/navigation/custom_bottom_navigation_bar.dart';
import '../../../../widgets/uncategorized/custom_clipper_widget.dart';
import '../selections_screen.dart';
import 'add_new_selection_photo_widget.dart';
import 'add_new_selections_input.dart';
import 'add_new_selections_text.dart';

class AddNewSelectionScreen extends StatelessWidget {
  const AddNewSelectionScreen({Key? key}) : super(key: key);
  static const routeName = '/add_new_selection_screen.dart';
  static const AddNewSelectionsText title = AddNewSelectionsText();
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
                  // child: const TalesSelectionWidget(),
                ),
              ),
              // Container(
              //   color: CustomColors.white,
              //   child: ImageIcon(
              //     CustomIconsImg.arrowLeftCircle,
              //     // color: CustomColors.black,
              //     size: screen.width * 0.2,
              //   ),
              // ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(screen.width * 0.05),
            child: const AddNewSelectionsTextName(),
          ),

          const Align(
              alignment: Alignment(0, -0.8),
              child: AddNewSelectionPhotoWidget()),
          const Align(
              alignment: Alignment(-0.85, -0.2),
              child: AddNewSelectionsTextDescription()),
          const Align(
              alignment: Alignment(0, 0), child: AddNewSelectionsInput()),
          const Align(
              alignment: Alignment(0, 0.4),
              child: AddNewSelectionsTextAddAudio()),

          // const Align(alignment: Alignment(0, 0), child: WrapSelectionsList()),
        ],
      ),
    );
  }
}

AppBar _appBar(Size screen, AddNewSelectionsText title, context) {
  return AppBar(
    actions: <Widget>[
      Padding(
        padding: EdgeInsets.only(right: screen.width * 0.04),
        child: TextButton(
          child: const AddNewSelectionsTextReady(),
          onPressed: () {},
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
        // height: screen.height * 0.0004,
        // width: screen.width * 0.000004,
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
