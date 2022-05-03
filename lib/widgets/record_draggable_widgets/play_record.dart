import 'package:flutter/material.dart';
import '../../utils/consts/custom_colors.dart';
import '../buttons/records_buttons/play_record_buttons.dart';
import '../buttons/records_buttons/play_record_upbar_buttons.dart';
import '../texts/record_screen_text.dart';
import 'play_record_progress.dart';

class PlayRecord extends StatelessWidget {
  const PlayRecord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final SoundBloc _soundBloc = BlocProvider.of<SoundBloc>(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: DraggableScrollableSheet(
            initialChildSize: 0.93,
            maxChildSize: 0.93,
            minChildSize: 0.9,
            builder: (context, scrollController) {
              return Container(
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: CustomColors.boxShadow,
                            spreadRadius: 3,
                            blurRadius: 10)
                      ],
                      color: CustomColors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Stack(
                    children: const [
                      Align(
                          alignment: Alignment(-1, -1),
                          child: PlayRecordUpbarButtons()),
                      Align(
                          alignment: Alignment(0, -0.4),
                          child: AudioNameText()),
                      Align(
                          alignment: Alignment(0, 0.25),
                          child: PlayRecordProgres()),
                      Align(
                          alignment: Alignment(0, 1),
                          child: PlayRecordButtons()),
                    ],
                  ));
            }),
      ),
    );
  }
}
