import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/audio.dart';
import '../../../repositorys/tales_list_repository.dart';
import 'selection_buttons_audio.dart';
import '../../../widgets/texts/main_screen_text.dart';
import 'active_tales_list_widget.dart';

// class AudioDraggableWidget extends StatefulWidget {
class AudioDraggableWidget extends StatelessWidget {
  const AudioDraggableWidget({Key? key}) : super(key: key);

//   @override
//   State<AudioDraggableWidget> createState() => _AudioDraggableWidgetState();
// }

// class _AudioDraggableWidgetState extends State<AudioDraggableWidget> {
  @override
  Widget build(BuildContext context) {
    final List<AudioTale> talesList =
        RepositoryProvider.of<TalesListRepository>(context)
            .getActiveTalesList();
    // print('${talesList.first.compilationsId} &&&');
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
              child: Stack(
                children: [
                  const SelectionButtonsAudio(),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: talesList.isNotEmpty
                        ? const ActiveTalesListWidget()
                        : const SelectionText9(),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
