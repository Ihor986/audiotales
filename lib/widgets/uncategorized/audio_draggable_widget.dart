import 'package:flutter/material.dart';

import '../buttons/main_screen_buttons/selection_buttons_audio.dart';

class AudioDraggableWidget extends StatefulWidget {
  const AudioDraggableWidget({Key? key}) : super(key: key);

  @override
  State<AudioDraggableWidget> createState() => _AudioDraggableWidgetState();
}

class _AudioDraggableWidgetState extends State<AudioDraggableWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: DraggableScrollableSheet(
            initialChildSize: 0.57,
            maxChildSize: 0.57,
            minChildSize: 0.57,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.15),
                          spreadRadius: 3,
                          blurRadius: 10)
                    ],
                    color: Color.fromRGBO(246, 246, 246, 1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: SingleChildScrollView(
                  child: const SelectionButtonsAudio(),
                  controller: scrollController,
                ),
              );
            }),
      ),
    );
  }
}
