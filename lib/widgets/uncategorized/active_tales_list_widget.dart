import 'package:audiotales/utils/consts/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../models/audio.dart';
import '../../models/tales_list.dart';
import '../../repositorys/tales_list_repository.dart';
import '../../utils/consts/custom_icons_img.dart';
import '../texts/audio_list_text/audio_list_text.dart';
import '../../pages/main_screen/main_screen_block/main_screen_bloc.dart';

class ActiveTalesListWidget extends StatelessWidget {
  const ActiveTalesListWidget({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenBloc, MainScreenState>(
      builder: (context, state) {
        Size screen = MediaQuery.of(context).size;
        final TalesList _talesListRep =
            RepositoryProvider.of<TalesListRepository>(context)
                .getTalesListRepository();
        final List<AudioTale> _talesList = _talesListRep.getActiveTalesList();
        final MainScreenBloc _mainScreenBloc =
            BlocProvider.of<MainScreenBloc>(context);
        return ListView.builder(
          itemCount: _talesList.length,
          // itemCount: 10,
          itemBuilder: (_, i) {
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
                            _mainScreenBloc.add(ClickPlayEvent(_talesList[i]));
                          },
                          icon: ImageIcon(
                            CustomIconsImg.playBlueSolo,
                            color: color,
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
                            AudioListText(time: _talesList[i].time),
                          ],
                        ),
                      ],
                    ),
                    PopupMenuButton(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      icon: SvgPicture.asset(
                        CustomIconsImg.moreHorizontRounded,
                        height: 3,
                        color: CustomColors.black,
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: const Text('Удалить'),
                          value: () {
                            _mainScreenBloc.add(DeleteAudioEvent(
                                id: _talesList[i].id,
                                talesList: _talesListRep));
                          },
                        ),
                        PopupMenuItem(
                          child: const Text('Подробнее об аудиозаписи'),
                          value: () {},
                        ),
                      ],
                      onSelected: (Function value) {
                        value();
                      },
                    ),
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
        );
      },
    );
  }
}
