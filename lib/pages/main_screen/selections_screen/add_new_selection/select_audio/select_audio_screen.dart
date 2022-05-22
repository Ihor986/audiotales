import 'package:flutter/material.dart';

import '../../../../../utils/consts/custom_colors.dart';
import '../../../../../utils/consts/custom_icons_img.dart';
import '../../../../../widgets/uncategorized/custom_clipper_widget.dart';
import 'audiolist_select_auio_widget.dart';
import 'select_audio_input_widget.dart';
import 'select_audio_text.dart';

class SelectAudioScreen extends StatelessWidget {
  const SelectAudioScreen({Key? key}) : super(key: key);
  static const routeName = '/select_audio_screen.dart';
  static const SelectAudioText title = SelectAudioText();
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
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: AudiolistSelectAudioWidget(),
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
          const Align(
            alignment: Alignment(0, -0.9),
            child: SelectAudioSearchWidget(),
          ),
          // const Align(
          //     alignment: Alignment(0, 0.5),
          //     child: AudiolistSelectAudioWidget()),

          // const Align(alignment: Alignment(0, 0), child: WrapSelectionsList()),
        ],
      ),
    );
  }
}

AppBar _appBar(Size screen, SelectAudioText title, context) {
  return AppBar(
    actions: <Widget>[
      Padding(
        padding: EdgeInsets.only(right: screen.width * 0.04),
        child: TextButton(
          child: const SelectAudioTextAdd(),
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
