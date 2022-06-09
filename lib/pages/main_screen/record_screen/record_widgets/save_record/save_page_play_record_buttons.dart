import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../repositorys/tales_list_repository.dart';
import '../../../../../utils/consts/custom_colors.dart';
import '../../../../../utils/consts/custom_icons_img.dart';
import '../../../main_screen_block/main_screen_bloc.dart';

class SavePagePlayRecordButtons extends StatelessWidget {
  const SavePagePlayRecordButtons({Key? key}) : super(key: key);
//  final AudioTale path;
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    final TalesListRepository _talesListRep =
        RepositoryProvider.of<TalesListRepository>(context);
    final MainScreenBloc _player = BlocProvider.of<MainScreenBloc>(context);
    return Container(
      width: screen.width * 1,
      foregroundDecoration: const BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.center,
          image: CustomIconsImg.play,
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Align(
        alignment: const Alignment(0, -0.75),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                _player.add(Rewind15Event(-15));
              },
              icon: const ImageIcon(
                CustomIconsImg.minus15,
                size: 25,
              ),
            ),
            IconButton(
              onPressed: () async {
                _player.add(ClickPlayEvent(_talesListRep
                    .getTalesListRepository()
                    .fullTalesList
                    .first));
              },
              icon: const Icon(Icons.pause, color: CustomColors.invisible),
            ),
            IconButton(
              onPressed: () {
                _player.add(Rewind15Event(15));
              },
              icon: const ImageIcon(
                CustomIconsImg.plus15,
                size: 25,
              ),
            ),
          ],
        ),
      ),
      height: screen.height * 0.25,
    );
  }
}
