import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/tales_list.dart';
import '../../repositorys/tales_list_repository.dart';
import '../../utils/consts/custom_colors.dart';
import '../../utils/consts/custom_icons_img.dart';
import '../alerts/deleted/remove_to_deleted_confirm.dart';

class CustomPopUpMenu extends StatelessWidget {
  const CustomPopUpMenu({Key? key, required this.id}) : super(key: key);
  final String id;
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
          child: const Text('Удалить'),
          value: () {
            RemoveToDeletedConfirm.instance.deletedConfirm(
              screen: screen,
              context: context,
              id: id,
              talesList: _talesListRep,
            );
            // _mainScreenBloc.add(DeleteAudioEvent(
            //     id: _talesList[i].id,
            //     talesList: _talesListRep));
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
    );
  }
}
