import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/navigation_bloc/navigation_bloc.dart';
import '../../bloc/sound_bloc/sound_bloc.dart';
import '../../utils/consts/custom_colors.dart';
import '../../utils/consts/custom_icons_img.dart';
import 'recordering_timer.dart';

class Recordering extends StatelessWidget {
  const Recordering({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    num screenHeight = MediaQuery.of(context).size.height;
    num screenWidth = MediaQuery.of(context).size.width;
    final SoundBloc _soundBloc = BlocProvider.of<SoundBloc>(context);
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
                    children: [
                      RecorderingTimer(),
                      Align(
                          alignment: const Alignment(0, 1),
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
                              onPressed: () async {
                                context.read<NavigationBloc>().add(
                                    StartRecordNavEvent(
                                        soundIndex:
                                            _soundBloc.sound.soundIndex + 1));
                                context
                                    .read<SoundBloc>()
                                    .add(StartRecordEvent());
                              },
                              icon: const Icon(Icons.pause,
                                  color: CustomColors.invisible),
                            ),
                            height: screenHeight * 0.25,
                          )),
                    ],
                  ));
            }),
      ),
    );
  }
}
