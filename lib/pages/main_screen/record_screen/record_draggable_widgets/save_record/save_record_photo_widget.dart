import 'package:flutter/material.dart';
import '../../../../../utils/consts/custom_colors.dart';
import '../../../../../utils/consts/custom_icons_img.dart';

class SaveRecordPhotoWidget extends StatelessWidget {
  const SaveRecordPhotoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final SoundBloc _soundBloc = BlocProvider.of<SoundBloc>(context);
    Size screen = MediaQuery.of(context).size;
    return Container(
      width: screen.width * 0.6,
      height: screen.width * 0.6,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: CustomColors.boxShadow, spreadRadius: 3, blurRadius: 10)
        ],
        color: CustomColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: IconButton(
        onPressed: () {},
        icon: const ImageIcon(
          CustomIconsImg.emptyfoto,
          color: CustomColors.iconsColorPlayRecUpbar,
          size: 50,
        ),
      ),
    );
  }
}
