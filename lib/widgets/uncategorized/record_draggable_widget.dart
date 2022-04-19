import 'package:audiotales/utils/consts/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/navigation_bloc/navigation_bloc.dart';
import '../../services/audioService.dart';
import '../../utils/consts/custom_icons_img.dart';

class RecordDraggableWidget extends StatefulWidget {
  const RecordDraggableWidget({Key? key}) : super(key: key);

  @override
  State<RecordDraggableWidget> createState() => _RecordDraggableWidgetState();
}

class _RecordDraggableWidgetState extends State<RecordDraggableWidget> {
  SoundService sound = SoundService();

  @override
  void initState() {
    super.initState();
    sound.initRecorder();
    sound.audioPlayer.openPlayer().then((value) {
      setState(() {
        sound.isRecoderReady = true;
      });
      sound.clickRecorder();
    });
  }

  @override
  void dispose() {
    sound.recorder.closeRecorder();
    sound.audioPlayer.stopPlayer();
    sound.audioPlayer.closePlayer();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    num screenHeight = MediaQuery.of(context).size.height;
    num screenWidth = MediaQuery.of(context).size.width;
    // return BlocBuilder<NavigationBloc, NavigationState>(
    //     builder: (context, state) {
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
                            //  Color.fromRGBO(0, 0, 0, 0.15),
                            spreadRadius: 3,
                            blurRadius: 10)
                      ],
                      color: CustomColors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Align(
                      alignment: const Alignment(0, 0.7),
                      child: Container(
                        width: screenWidth * 1,
                        foregroundDecoration: const BoxDecoration(
                          image: DecorationImage(
                            alignment: Alignment.center,
                            image: CustomIconsImg.pause2,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        child: IconButton(
                          onPressed: () {
                            sound.clickRecorder();
                            // context
                            //     .read<NavigationBloc>()
                            //     .add(StopRecordEvent());
                            // state.sound.stopRecorder();
                            print('pres pause');
                          },
                          icon: const Icon(Icons.pause,
                              color: CustomColors.invisible),
                        ),
                        height: screenHeight * 0.13,
                      )));
            }),
      ),
    );
    // });
  }
}
