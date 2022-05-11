import 'package:audiotales/models/tales_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../bloc/navigation_bloc/navigation_bloc.dart';
import '../../../../../repositorys/tales_list_repository.dart';
import '../../../../../utils/consts/custom_icons_img.dart';
import '../../../main_screen_block/main_screen_bloc.dart';

class SaveRecordUpbarButtons extends StatelessWidget {
  const SaveRecordUpbarButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationBloc _navdBloc = BlocProvider.of<NavigationBloc>(context);
    final MainScreenBloc _mainBloc = BlocProvider.of<MainScreenBloc>(context);
    final TalesList _talesListRep =
        RepositoryProvider.of<TalesListRepository>(context)
            .getTalesListRepository();
    Size screen = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.all(screen.width * 0.04),
          child: IconButton(
            onPressed: () {
              _navdBloc.add(ChangeCurrentIndexEvent(currentIndex: 0));
            },
            icon: const ImageIcon(
              CustomIconsImg.arrowDownCircle,
              size: 25,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(screen.width * 0.04),
          child: PopupMenuButton(
            icon: const Icon(Icons.more_horiz_rounded),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Добавить в подборку'),
                value: () {},
              ),
              PopupMenuItem(
                child: Text('Редактировать название'),
                value: () {},
              ),
              PopupMenuItem(
                child: Text('Поделиться'),
                value: () {},
              ),
              PopupMenuItem(
                child: Text('Скачать'),
                value: () {},
              ),
              PopupMenuItem(
                child: Text('Удалить'),
                value: () {
                  _mainBloc.add(DeleteAudioEvent(
                      list: _talesListRep,
                      audio: _talesListRep.fullTalesList.last));
                  _navdBloc.add(ChangeCurrentIndexEvent(currentIndex: 0));
                },
              ),
            ],
            onSelected: (Function value) {
              value();
            },
          ),
        )

        // IconButton(
        //   onPressed: () {},
        //   icon: IconButton(
        //       onPressed: () {}, icon: const Icon(Icons.more_horiz_rounded)),
        // ),
      ],
    );
  }
}
