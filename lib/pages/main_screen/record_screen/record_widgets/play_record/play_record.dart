import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/custom_colors.dart';
import '../../../../../widgets/toasts/progres/show_circular_progress.dart';
import '../../record_bloc/record_bloc.dart';
import '../recordering/record_screen_text.dart';
import 'play_record_buttons.dart';
import 'play_record_progress.dart';
import 'play_record_upbar_buttons.dart';

class PlayRecord extends StatelessWidget {
  const PlayRecord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecordBloc, RecordState>(
      builder: (context, state) {
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
                          blurRadius: 10),
                    ],
                    color: CustomColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: state.isProgress
                      ? const ProgresWidget()
                      : Stack(
                          children: const [
                            Align(
                              alignment: Alignment(-1, -1),
                              child: PlayRecordUpbarButtons(),
                            ),
                            Align(
                              alignment: Alignment(0, -0.4),
                              child: AudioNameText(),
                            ),
                            Align(
                              alignment: Alignment(0, 0),
                              child: PlayRecordProgres(),
                            ),
                            Align(
                              alignment: Alignment(0, 1),
                              child: PlayRecordButtons(),
                            ),
                          ],
                        ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
