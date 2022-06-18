import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../bloc/navigation_bloc/navigation_bloc.dart';
import '../../../../../models/tales_list.dart';
import '../../../../../repositorys/tales_list_repository.dart';
import '../../../../../utils/consts/custom_colors.dart';
import '../../../../../utils/consts/custom_icons_img.dart';
import '../../../../../widgets/alerts/deleted/remove_to_deleted_confirm.dart';
import '../../../main_screen_block/main_screen_bloc.dart';
import '../play_record/play_record_progress.dart';

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
                          child: _SaveRecordUpbarButtons()),
                      const Align(
                          alignment: Alignment(0, -0.7),
                          child: _SaveRecordPhotoWidget()),
                      const Align(
                          alignment: Alignment(0, 0.05),
                          child: Text('Название подборки')),
                      Align(
                          alignment: const Alignment(0, 0.15),
                          child: Text(_talesListRep
                              .getTalesListRepository()
                              .getActiveTalesList()
                              .first
                              .name)),
                      const Align(
                          alignment: Alignment(0, 0.4),
                          child: PlayRecordProgres()),
                      const Align(
                          alignment: Alignment(0, 1),
                          child: _SavePagePlayRecordButtons()),
                    ],
                  ));
            }),
      ),
    );
  }
}

class _SaveRecordUpbarButtons extends StatelessWidget {
  const _SaveRecordUpbarButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationBloc _navdBloc = BlocProvider.of<NavigationBloc>(context);
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
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            icon: const Icon(Icons.more_horiz_rounded),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text('Добавить в подборку'),
                value: () {},
              ),
              PopupMenuItem(
                child: const Text('Редактировать название'),
                value: () {},
              ),
              PopupMenuItem(
                child: const Text('Поделиться'),
                value: () {},
              ),
              PopupMenuItem(
                child: const Text('Скачать'),
                value: () {},
              ),
              PopupMenuItem(
                child: const Text('Удалить'),
                value: () {
                  RemoveToDeletedConfirm.instance.deletedConfirm(
                    screen: screen,
                    context: context,
                    id: _talesListRep.fullTalesList.first.id,
                    talesList: _talesListRep,
                    isClosePage: true,
                  );

                  // _navdBloc.add(ChangeCurrentIndexEvent(currentIndex: 0));
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

class _SaveRecordPhotoWidget extends StatelessWidget {
  const _SaveRecordPhotoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final SoundBloc _soundBloc = BlocProvider.of<SoundBloc>(context);
    Size screen = MediaQuery.of(context).size;
    return Container(
      width: screen.width * 0.6,
      height: screen.width * 0.6,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: CustomColors.boxShadow, spreadRadius: 3, blurRadius: 10)
        ],
        color: CustomColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: IconButton(
        onPressed: () {},
        icon: const ImageIcon(
          CustomIconsImg.emptyfoto,
          color: CustomColors.iconsColorPlayRecUpbar,
          size: 50,
        ),
      ),
    );
  }
}

class _SavePagePlayRecordButtons extends StatelessWidget {
  const _SavePagePlayRecordButtons({Key? key}) : super(key: key);
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
