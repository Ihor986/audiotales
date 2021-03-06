import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../bloc/navigation_bloc/navigation_bloc.dart';
import '../../../../../utils/custom_colors.dart';
import '../../../../../utils/custom_img.dart';
import '../../record_bloc/record_bloc.dart';
import 'cancel_button.dart';
import 'record_animation.dart';
import 'record_screen_text.dart';
import 'recordering_timer.dart';

class Recordering extends StatefulWidget {
  const Recordering({
    Key? key,
  }) : super(key: key);
  // static const String routeName = '/record';

  @override
  State<Recordering> createState() => _RecorderingState();
}

class _RecorderingState extends State<Recordering> {
  RecordBloc? soundBloc;
  @override
  void initState() {
    soundBloc = context.read<RecordBloc>();
    soundBloc!.sound.initRecorder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size _screen = MediaQuery.of(context).size;
    final NavigationBloc _navigationBloc = context.read<NavigationBloc>();

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
                  const Align(
                    child: CancelRecordButton(),
                    alignment: Alignment(0.92, -0.95),
                  ),
                  const Align(
                    alignment: Alignment(0, -0.7),
                    child: RecordText(),
                  ),
                  const RecorderingAnimation(),
                  const RecorderingTimer(),
                  Align(
                    alignment: const Alignment(0, 1),
                    child: Container(
                      width: _screen.width * 1,
                      foregroundDecoration: const BoxDecoration(
                        image: DecorationImage(
                          alignment: Alignment.center,
                          image: CustomImg.pause2,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      child: IconButton(
                        onPressed: () async {
                          soundBloc!.add(StartRecordEvent());
                          _navigationBloc.add(StartRecordNavEvent());
                        },
                        icon: const Icon(Icons.pause,
                            color: CustomColors.invisible),
                      ),
                      height: _screen.height * 0.25,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
