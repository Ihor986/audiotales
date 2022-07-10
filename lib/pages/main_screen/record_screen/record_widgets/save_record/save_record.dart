import 'dart:io';

import 'package:audiotales/models/selections.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../bloc/main_screen_block/main_screen_bloc.dart';
import '../../../../../bloc/navigation_bloc/navigation_bloc.dart';
import '../../../../../models/audio.dart';
import '../../../../../models/selection.dart';
import '../../../../../models/tales_list.dart';
import '../../../../../repositorys/selections_repositiry.dart';
import '../../../../../repositorys/tales_list_repository.dart';
import '../../../../../utils/custom_colors.dart';
import '../../../../../utils/custom_icons.dart';
import '../../../../../utils/custom_img.dart';
import '../../../../../widgets/alerts/deleted/remove_to_deleted_confirm.dart';
import '../../../selections_screen/bloc/selections_bloc.dart';
import '../../../selections_screen/selections_screen.dart';
import '../play_record/play_record_progress.dart';

class SaveRecord extends StatelessWidget {
  const SaveRecord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _screen = MediaQuery.of(context).size;
    return BlocBuilder<MainScreenBloc, MainScreenState>(
      builder: (context, state) {
        final AudioTale _audio = context
            .read<TalesListRepository>()
            .getTalesListRepository()
            .getActiveTalesList()
            .first;
        final SelectionsList _selectionsRep = context
            .read<SelectionsListRepository>()
            .getSelectionsListRepository();
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: DraggableScrollableSheet(
              initialChildSize: 1,
              maxChildSize: 1,
              minChildSize: 1,
              builder: (context, scrollController) {
                return SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  reverse: true,
                  child: Container(
                    height: _screen.height * 0.85,
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
                              selection:
                                  _selectionsRep.getSelectionByAudioId(_audio)),
                        ),
                        Align(
                          alignment: const Alignment(0, 0.05),
                          child: _SelectionName(
                              readOnly: state.readOnly,
                              selection:
                                  _selectionsRep.getSelectionByAudioId(_audio)),
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
                    ),
                  ),
                );
              },
            ),
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
    final Size _screen = MediaQuery.of(context).size;
    final NavigationBloc _navdBloc = context.read<NavigationBloc>();
    final MainScreenBloc _mainScreenBloc = context.read<MainScreenBloc>();
    final TalesList _talesListRep =
        context.read<TalesListRepository>().getTalesListRepository();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.all(_screen.width * 0.04),
          child: IconButton(
            onPressed: () {
              _navdBloc.add(ChangeCurrentIndexEvent(currentIndex: 0));
            },
            icon: SvgPicture.asset(
              CustomIconsImg.arrowDownCircle,
              color: CustomColors.black,
              height: _screen.height * 0.04,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(_screen.width * 0.04),
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
                        _mainScreenBloc.add(ChangeAudioNameEvent(
                          audio: audio,
                        ));
                      },
                    ),
                    PopupMenuItem(
                      child: const Text('Поделиться'),
                      value: () {
                        context.read<MainScreenBloc>().add(
                              ShareAudioEvent(
                                audio: audio,
                              ),
                            );
                      },
                    ),
                    PopupMenuItem(
                      child: const Text('Скачать'),
                      value: () {
                        context.read<MainScreenBloc>().add(DownloadAudioEvent(
                              audioList: [audio.id],
                              talesList: _talesListRep,
                            ));
                      },
                    ),
                    PopupMenuItem(
                      child: const Text('Удалить'),
                      value: () {
                        RemoveToDeletedConfirm.instance.deletedConfirm(
                          screen: _screen,
                          context: context,
                          idList: [_talesListRep.fullTalesList.first.id],
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
                    _mainScreenBloc.add(SaveChangedAudioNameEvent(
                      audio: audio,
                      fullTalesList: _talesListRep,
                    ));
                  },
                  child: const Text(
                    'Готово',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
        )
      ],
    );
  }
}

class _SaveRecordPhotoWidget extends StatelessWidget {
  const _SaveRecordPhotoWidget({
    Key? key,
    required this.readOnly,
    required this.selection,
  }) : super(key: key);

  final bool readOnly;
  final Selection? selection;

  @override
  Widget build(BuildContext context) {
    final DecorationImage? _image =
        selection == null ? null : _decorationImageReadOnly(selection!);
    Size screen = MediaQuery.of(context).size;
    return Container(
      width: screen.height * 0.34,
      height: screen.height * 0.34,
      decoration: BoxDecoration(
        image: _image,
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
  @override
  Widget build(BuildContext context) {
    final Size _screen = MediaQuery.of(context).size;
    final TalesListRepository _talesListRep =
        context.read<TalesListRepository>();
    final MainScreenBloc _mainScreenBloc = context.read<MainScreenBloc>();
    return Container(
      width: _screen.width * 1,
      foregroundDecoration: const BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.center,
          image: CustomImg.play,
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
                _mainScreenBloc.add(Rewind15Event(-15));
              },
              icon: SvgPicture.asset(
                CustomIconsImg.minus15,
              ),
            ),
            IconButton(
              onPressed: () async {
                _mainScreenBloc.add(ClickPlayEvent(
                    audioList:
                        _talesListRep.getTalesListRepository().fullTalesList,
                    indexAudio: 0));
              },
              icon: const Icon(Icons.pause, color: CustomColors.invisible),
            ),
            IconButton(
              onPressed: () {
                _mainScreenBloc.add(Rewind15Event(15));
              },
              icon: SvgPicture.asset(
                CustomIconsImg.plus15,
              ),
            ),
          ],
        ),
      ),
      height: _screen.height * 0.25,
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
    final Size _screen = MediaQuery.of(context).size;
    return TextFormField(
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      initialValue: audio.name,
      onChanged: (value) {
        context.read<MainScreenBloc>().add(
              EditingAudioNameEvent(value: value),
            );
      },
      readOnly: readOnly,
      style: TextStyle(
        color: CustomColors.black,
        fontSize: _screen.height * 0.015,
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
    final Size _screen = MediaQuery.of(context).size;
    final String _text = selection?.name ?? 'Название подборки';
    return Text(
      _text,
      style: TextStyle(
        color: readOnly ? CustomColors.black : CustomColors.noTalesText,
        fontSize: _screen.height * 0.027,
      ),
    );
  }
}
