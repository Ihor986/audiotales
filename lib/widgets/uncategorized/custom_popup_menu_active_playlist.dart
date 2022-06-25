import 'package:audiotales/models/audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../bloc/navigation_bloc/navigation_bloc.dart';
import '../../models/tales_list.dart';
import '../../pages/main_screen/main_screen_block/main_screen_bloc.dart';
import '../../pages/main_screen/record_screen/sound_bloc/sound_bloc.dart';
import '../../pages/main_screen/selections_screen/bloc/selections_bloc.dart';
import '../../pages/main_screen/selections_screen/selections_screen.dart';
import '../../repositorys/tales_list_repository.dart';
import '../../utils/consts/custom_colors.dart';
import '../../utils/consts/custom_icons_img.dart';
import '../alerts/deleted/remove_to_deleted_confirm.dart';

class CustomPopUpMenu extends StatelessWidget {
  const CustomPopUpMenu({
    Key? key,
    required this.audio,
    // required this.fullTalesList,
  }) : super(key: key);
  final AudioTale audio;
  // final TalesList fullTalesList;
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    final TalesList _talesListRep =
        RepositoryProvider.of<TalesListRepository>(context)
            .getTalesListRepository();
    return PopupMenuButton(
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
          child: const Text('Переименовать'),
          value: () {
            context.read<MainScreenBloc>().add(ChangeAudioNameEvent(
                  audio: audio,
                ));
          },
        ),
        PopupMenuItem(
          child: const Text('Добавить в подборку'),
          value: () {
            context
                .read<SelectionsBloc>()
                .add(SelectSelectionsEvent(audio: audio));
            Navigator.pushNamed(
              context,
              SelectionsScreen.routeName,
            );
          },
        ),
        PopupMenuItem(
          child: const Text('Удалить'),
          value: () {
            RemoveToDeletedConfirm.instance.deletedConfirm(
              screen: screen,
              context: context,
              id: audio.id,
              talesList: _talesListRep,
            );
          },
        ),
        PopupMenuItem(
          child: const Text('Поделиться'),
          value: () {},
        ),
      ],
      onSelected: (Function value) {
        value();
      },
    );
  }
}
