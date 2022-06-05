import 'package:audiotales/utils/consts/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/audio.dart';
import '../../utils/consts/custom_icons_img.dart';
import '../texts/audio_list_text/audio_list_text.dart';
import '../../pages/main_screen/main_screen_block/main_screen_bloc.dart';

class TalesListWidget extends StatelessWidget {
  const TalesListWidget({
    Key? key,
    required this.talesList,
    this.isDisactive,
  }) : super(key: key);
  final List<AudioTale> talesList;
  final bool? isDisactive;
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    final MainScreenBloc _mainScreenBloc =
        BlocProvider.of<MainScreenBloc>(context);
    return ListView.builder(
      itemCount: talesList.length,
      // itemCount: 10,
      itemBuilder: (_, i) {
        return Padding(
          padding: EdgeInsets.all(screen.height * 0.005),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (isDisactive == true) {
                          return;
                        }
                        // print('11111111111111');
                        _mainScreenBloc.add(ClickPlayEvent(talesList[i]));
                      },
                      icon: ImageIcon(
                        CustomIconsImg.playBlueSolo,
                        color: CustomColors.blueSoso,
                        size: screen.height,
                      ),
                    ),
                    SizedBox(
                      width: screen.width * 0.05,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(talesList[i].name),
                        AudioListText(index: i),
                      ],
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {
                      if (isDisactive == true) {
                        return;
                      }
                    },
                    icon: const Icon(Icons.more_horiz_rounded)),
              ],
            ),
            decoration: BoxDecoration(
              color: CustomColors.white,
              border: Border.all(color: CustomColors.audioBorder),
              borderRadius: const BorderRadius.all(Radius.circular(41)),
            ),
            foregroundDecoration: isDisactive == true
                ? BoxDecoration(
                    color: CustomColors.disactive,
                    border: Border.all(color: CustomColors.audioBorder),
                    borderRadius: const BorderRadius.all(Radius.circular(41)),
                  )
                : null,
          ),
        );
      },
    );
  }
}
