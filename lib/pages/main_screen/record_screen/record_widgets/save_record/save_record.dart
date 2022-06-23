import 'dart:io';

import 'package:audiotales/models/selections.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../bloc/navigation_bloc/navigation_bloc.dart';
import '../../../../../models/audio.dart';
import '../../../../../models/tales_list.dart';
import '../../../../../repositorys/selections_repositiry.dart';
import '../../../../../repositorys/tales_list_repository.dart';
import '../../../../../utils/consts/custom_colors.dart';
import '../../../../../utils/consts/custom_icons_img.dart';
import '../../../../../widgets/alerts/deleted/remove_to_deleted_confirm.dart';
import '../../../main_screen_block/main_screen_bloc.dart';
import '../../../selections_screen/bloc/selections_bloc.dart';
import '../../../selections_screen/selections_screen.dart';
import '../../sound_bloc/sound_bloc.dart';
import '../play_record/play_record_progress.dart';

class SaveRecord extends StatelessWidget {
  const SaveRecord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SoundBloc, SoundInitial>(
      builder: (context, state) {
        final AudioTale _audio =
            RepositoryProvider.of<TalesListRepository>(context)
                .getTalesListRepository()
                .getActiveTalesList()
                .first;
        final SelectionsList _selectionsRep =
            RepositoryProvider.of<SelectionsListRepository>(context)
                .getSelectionsListRepository();
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
                          Align(
                              alignment: const Alignment(-1, -1),
                              child: _SaveRecordUpbarButtons(
                                readOnly: state.readOnly,
                                audio: _audio,
                              )),
                          Align(
                            alignment: const Alignment(0, -0.7),
                            child: _SaveRecordPhotoWidget(
                                readOnly: state.readOnly,
                                selection: _selectionsRep
                                    .getSelectionByAudioId(_audio)),
                          ),
                          Align(
                            alignment: const Alignment(0, 0.05),
                            child: _SelectionName(
                                readOnly: state.readOnly,
                                selection: _selectionsRep
                                    .getSelectionByAudioId(_audio)),
                          ),
                          Align(
                            alignment: const Alignment(0, 0.15),
                            child: _AudioName(
                              audio: _audio,
                              readOnly: state.readOnly,
                            ),
                          ),
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
      },
    );
  }
}

class _SaveRecordUpbarButtons extends StatelessWidget {
  const _SaveRecordUpbarButtons({
    Key? key,
    required this.audio,
    required this.readOnly,
  }) : super(key: key);

  final AudioTale audio;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    final NavigationBloc _navdBloc = context.read<NavigationBloc>();
    final _soundBloc = context.read<SoundBloc>();
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
          child: readOnly
              ? PopupMenuButton(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  icon: const Icon(Icons.more_horiz_rounded),
                  itemBuilder: (context) => [
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
                      child: const Text('Редактировать название'),
                      value: () {
                        _soundBloc.add(ChangeAudioNameEvent(
                          name: audio.name,
                        ));
                      },
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

                        _navdBloc.add(ChangeCurrentIndexEvent(currentIndex: 0));
                      },
                    ),
                  ],
                  onSelected: (Function value) {
                    value();
                  },
                )
              : TextButton(
                  onPressed: () {
                    _soundBloc.add(SaveChangedAudioNameEvent(
                      audio: audio,
                      fullTalesList: _talesListRep,
                    ));
                  },
                  child: const Text('Ready'),
                ),
        )
      ],
    );
  }
}

class _SaveRecordPhotoWidget extends StatelessWidget {
  const _SaveRecordPhotoWidget({
    Key? key,
    // required this.audio,
    required this.readOnly,
    required this.selection,
  }) : super(key: key);

  final bool readOnly;
  final Selection? selection;

  @override
  Widget build(BuildContext context) {
    var _image =
        selection == null ? null : _decorationImageReadOnly(selection!);
    Size screen = MediaQuery.of(context).size;
    return Container(
      width: screen.height * 0.34,
      height: screen.height * 0.34,
      decoration: BoxDecoration(
        image: _image,
        // image: _decorationImageReadOnly(selection!),
        boxShadow: const [
          BoxShadow(
              color: CustomColors.boxShadow, spreadRadius: 3, blurRadius: 10)
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      foregroundDecoration: readOnly
          ? null
          : const BoxDecoration(
              color: CustomColors.disactive,
            ),
    );
  }

  DecorationImage? _decorationImageReadOnly(Selection selection) {
    if (selection.photo != null) {
      try {
        return DecorationImage(
            image: MemoryImage(File(selection.photo ?? '').readAsBytesSync()),
            fit: BoxFit.cover);
      } catch (_) {}
    }

    if (selection.photoUrl != null) {
      try {
        return DecorationImage(
          image: CachedNetworkImageProvider(selection.photoUrl ?? ''),
          fit: BoxFit.cover,
        );
      } catch (_) {
        return null;
      }
    }
    return null;
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

class _AudioName extends StatelessWidget {
  const _AudioName({
    Key? key,
    required this.audio,
    required this.readOnly,
  }) : super(key: key);

  final AudioTale audio;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    return TextFormField(
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      initialValue: audio.name,
      onChanged: (value) {
        context.read<SoundBloc>().add(
              EditingAudioNameEvent(value: value),
            );
      },
      readOnly: readOnly,
      style: TextStyle(
        color: CustomColors.black,
        fontSize: screen.height * 0.015,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class _SelectionName extends StatelessWidget {
  const _SelectionName({
    Key? key,
    required this.selection,
    required this.readOnly,
  }) : super(key: key);

  final bool readOnly;
  final Selection? selection;

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    final String text = selection?.name ?? 'Название подборки';
    return Text(
      text,
      style: TextStyle(
        color: readOnly ? CustomColors.black : CustomColors.noTalesText,
        fontSize: screen.height * 0.027,
      ),
    );
  }
}
