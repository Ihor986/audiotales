import 'package:audiotales/utils/consts/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc/sound_bloc.dart';
import '../../bloc/navigation_bloc/navigation_bloc.dart';
import '../../services/audioService.dart';
import '../../utils/consts/custom_icons_img.dart';

class RecordDraggableWidget extends StatelessWidget {
  const RecordDraggableWidget({Key? key}) : super(key: key);

//   @override
//   State<RecordDraggableWidget> createState() => _RecordDraggableWidgetState();
// }

// class _RecordDraggableWidgetState extends State<RecordDraggableWidget> {
  // kk

  // @override
  // void initState() {
  //   super.initState();
  //   sound.initRecorder();
  //   sound.audioPlayer.openPlayer().then((value) {
  //     setState(() {
  //       sound.isRecoderReady = true;
  //     });
  //     // sound.record();
  //   });
  // }

  // @override
  // void dispose() {
  //   sound.recorder.closeRecorder();
  //   sound.audioPlayer.stopPlayer();
  //   sound.audioPlayer.closePlayer();

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    num screenHeight = MediaQuery.of(context).size.height;
    num screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider<SoundBloc>(
        create: (context) => SoundBloc(),
        child: BlocBuilder<SoundBloc, SoundState>(builder: (context, state) {
          SoundService sound = context.read<SoundBloc>().sound;
          if (sound.soundIndex == 0) {
            context
                .read<NavigationBloc>()
                .add(StartRecordNavEvent(soundIndex: sound.soundIndex + 1));
            context.read<SoundBloc>().add(StartRecordEvent());
          }
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
                            alignment: const Alignment(0, 1),
                            child: Container(
                              width: screenWidth * 1,
                              foregroundDecoration: BoxDecoration(
                                image: DecorationImage(
                                  alignment: Alignment.center,
                                  image: sound.soundIndex != 2
                                      ? CustomIconsImg.pause2
                                      : CustomIconsImg.play,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              child: IconButton(
                                onPressed: () async {
                                  // sound.clickRecorder();

                                  context.read<NavigationBloc>().add(
                                      StartRecordNavEvent(
                                          soundIndex: sound.soundIndex + 1));
                                  context
                                      .read<SoundBloc>()
                                      .add(StartRecordEvent());
                                },
                                icon: const Icon(Icons.pause,
                                    color: CustomColors.invisible),
                              ),
                              height: screenHeight * 0.25,
                            )));
                  }),
            ),
          );
        }));
  }
}
