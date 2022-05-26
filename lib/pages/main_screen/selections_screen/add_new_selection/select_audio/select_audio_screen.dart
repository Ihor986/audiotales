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

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: _appBar(context),
      body: Stack(
        children: [
          Column(
            children: [
              ClipPath(
                clipper: OvalBC(),
                child: Container(
                  height: screen.height / 7,
                  color: CustomColors.oliveSoso,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: AudiolistSelectAudioWidget(),
              ),
            ],
          ),
          const Align(
            alignment: Alignment(0, -0.9),
            child: SelectAudioSearchWidget(),
          ),
        ],
      ),
    );
  }
}

AppBar _appBar(BuildContext context) {
  Size screen = MediaQuery.of(context).size;
  const SelectAudioText title = SelectAudioText();
  return AppBar(
    actions: <Widget>[
      Padding(
        padding: EdgeInsets.only(right: screen.width * 0.04),
        child: TextButton(
          child: const SelectAudioTextAdd(),
          onPressed: () {
            Navigator.pop(context);
          },
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
