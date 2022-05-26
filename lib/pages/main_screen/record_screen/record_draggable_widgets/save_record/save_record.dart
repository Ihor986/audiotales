import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../repositorys/tales_list_repository.dart';
import '../../../../../utils/consts/custom_colors.dart';
import 'save_page_play_record_buttons.dart';
import 'save_record_upbar_buttons.dart';
import '../play_record/play_record_progress.dart';
import 'save_record_photo_widget.dart';

class SaveRecord extends StatelessWidget {
  const SaveRecord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TalesListRepository _talesListRep =
        RepositoryProvider.of<TalesListRepository>(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: DraggableScrollableSheet(
            initialChildSize: 1,
            maxChildSize: 1,
            minChildSize: 1,
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
                          alignment: Alignment(-1, -1),
                          child: SaveRecordUpbarButtons()),
                      const Align(
                          alignment: Alignment(0, -0.7),
                          child: SaveRecordPhotoWidget()),
                      const Align(
                          alignment: Alignment(0, 0.05),
                          child: Text('Название подборки')),
                      Align(
                          alignment: const Alignment(0, 0.15),
                          child: Text(_talesListRep
                              .getTalesListRepository()
                              .getActiveTalesList()
                              .last
                              .name)),
                      const Align(
                          alignment: Alignment(0, 0.4),
                          child: PlayRecordProgres()),
                      const Align(
                          alignment: Alignment(0, 1),
                          child: SavePagePlayRecordButtons()),
                    ],
                  ));
            }),
      ),
    );
  }
}
