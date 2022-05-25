import 'package:audiotales/utils/consts/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/audio.dart';
import '../../../../../repositorys/tales_list_repository.dart';
import '../../../../../utils/consts/custom_icons_img.dart';
import '../../../../../widgets/texts/audio_list_text/audio_list_text.dart';
import '../../bloc/selections_bloc.dart';

class AudiolistSelectAudioWidget extends StatelessWidget {
  const AudiolistSelectAudioWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<AudioTale> talesList =
        RepositoryProvider.of<TalesListRepository>(context)
            .getActiveTalesList();
    return BlocBuilder<SelectionsBloc, SelectionsState>(
      builder: (context, state) {
        final Size screen = MediaQuery.of(context).size;
        final SelectionsBloc _selectionsBloc =
            BlocProvider.of<SelectionsBloc>(context);
        List<AudioTale> _talesList = talesList;
        if (state.searchValue != null) {
          _talesList = talesList
              .where(
                  (element) => element.name.contains(state.searchValue ?? ''))
              .toList();
        }
        List<String> checkedList =
            _selectionsBloc.addAudioToSelectionService.checkedList;
        return SizedBox(
          height: screen.height * 0.5,
          child: ListView.builder(
            itemCount: _talesList.length,
            itemBuilder: (_, i) {
              bool isChecked = checkedList.contains(_talesList[i].id);
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
                              // print('11111111111111');
                              // _mainScreenBloc.add(ClickPlayEvent(talesList[i]));
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
                              Text(_talesList[i].name),
                              AudioListText(index: i),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            _selectionsBloc.add(CheckEvent(
                                isChecked: isChecked, id: _talesList[i].id));
                          },
                          icon: isChecked
                              ? const ImageIcon(CustomIconsImg.check)
                              : const ImageIcon(CustomIconsImg.uncheck)),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: CustomColors.white,
                    border: Border.all(color: CustomColors.audioBorder),
                    borderRadius: const BorderRadius.all(Radius.circular(41)),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
