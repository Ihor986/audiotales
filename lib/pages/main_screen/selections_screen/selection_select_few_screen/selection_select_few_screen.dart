import 'dart:io';

import 'package:audiotales/models/tales_list.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../models/selections.dart';
import '../../../../../repositorys/selections_repositiry.dart';
import '../../../../bloc/main_screen_block/main_screen_bloc.dart';
import '../../../../models/selection.dart';
import '../../../../models/tale.dart';
import '../../../../repositorys/tales_list_repository.dart';
import '../../../../services/minuts_text_convert_service.dart';
import '../../../../utils/custom_colors.dart';
import '../../../../utils/custom_icons.dart';
import '../../../../widgets/uncategorized/custom_clipper_widget.dart';
import '../../../../widgets/uncategorized/play_all_button.dart';
import '../add_new_selection/add_new_selections_text.dart';
import '../bloc/selections_bloc.dart';
import '../selections_screen.dart';
import '../widgets/selections_text.dart';

class SelectionSelectFewScreen extends StatelessWidget {
  const SelectionSelectFewScreen({
    Key? key,
    required this.selection,
  }) : super(key: key);
  static const routeName = '/selection_select_few_screen.dart';
  final Selection selection;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectionsBloc, SelectionsState>(
      builder: (context, state) {
        final SelectionsBloc _selectionsBloc =
            BlocProvider.of<SelectionsBloc>(context);

        return Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          appBar: AppBar(
            actions: <Widget>[
              _Action(
                selection: selection,
              ),
            ],
            backgroundColor: CustomColors.oliveSoso,
            centerTitle: true,
            elevation: 0,
            leading: IconButton(
              padding: const EdgeInsets.only(left: 16),
              icon: SvgPicture.asset(
                CustomIconsImg.arrowLeftCircle,
              ),
              onPressed: () {
                _selectionsBloc.changeSelectionService.readOnly = true;
                Navigator.pop(context);
              },
            ),
            title: const _TitleSelectionScreen(),
          ),
          body: _BodySelectionScreen(
            selection: selection,
            readOnly: _selectionsBloc.changeSelectionService.readOnly,
            route: '/selection_select_few_screen.dart',
          ),
        );
      },
    );
  }
}

class _Action extends StatelessWidget {
  const _Action({Key? key, required this.selection}) : super(key: key);
  final Selection selection;
  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    final SelectionsBloc _selectionsBloc = context.read<SelectionsBloc>();
    final SelectionsList _selectionsList =
        context.read<SelectionsListRepository>().getSelectionsListRepository();
    final TalesList talesList =
        context.read<TalesListRepository>().getTalesListRepository();
    if (_selectionsBloc.changeSelectionService.readOnly) {
      return Padding(
        padding: EdgeInsets.only(right: screen.width * 0.04),
        child: Column(
          children: [
            PopupMenuButton(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              icon: const Icon(Icons.more_horiz_rounded),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: const Text('Отменить выбор'),
                  value: () {
                    _selectionsBloc.add(UncheckAll());
                  },
                ),
                PopupMenuItem(
                  child: const Text('Добавить в подборку'),
                  value: () {
                    _selectionsBloc.add(SelectSelectionsForListAudiosEvent());
                    Navigator.pushNamed(
                      context,
                      SelectionsScreen.routeName,
                    );
                  },
                ),
                PopupMenuItem(
                  child: const Text('Поделиться'),
                  value: () {
                    context.read<MainScreenBloc>().add(
                          ShareAudiosEvent(
                            audioList:
                                talesList.getCompilation(id: selection.id),
                            idList: _selectionsBloc
                                .changeSelectionService.checkedList,
                            name: selection.name,
                          ),
                        );
                  },
                ),
                PopupMenuItem(
                  child: const Text('Скачать все'),
                  value: () {
                    context.read<MainScreenBloc>().add(DownloadAudioEvent(
                          audioList: _selectionsBloc
                              .changeSelectionService.checkedList,
                          talesList: talesList,
                        ));
                  },
                ),
                PopupMenuItem(
                  child: const Text('Удалить все'),
                  value: () {
                    context.read<SelectionsBloc>().add(
                          RemoveFromSelectionEvent(
                            audio: null,
                            talesList: talesList,
                            selectionId: selection.id,
                          ),
                        );
                  },
                ),
              ],
              onSelected: (Function value) {
                value();
              },
            ),
            const SizedBox(),
          ],
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(right: screen.width * 0.04),
        child: TextButton(
          child: const AddNewSelectionsTextReady(),
          onPressed: () {
            _selectionsBloc.add(
              SaveChangedSelectionEvent(
                selectionsList: _selectionsList,
                selection: selection,
              ),
            );
          },
        ),
      );
    }
  }
}

class _BodySelectionScreen extends StatelessWidget {
  const _BodySelectionScreen({
    Key? key,
    required this.selection,
    required this.readOnly,
    required this.route,
  }) : super(key: key);
  final String route;
  final Selection selection;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    final List<AudioTale> talesList =
        RepositoryProvider.of<TalesListRepository>(context)
            .getTalesListRepository()
            .getCompilation(id: selection.id);

    Size screen = MediaQuery.of(context).size;
    return Stack(
      children: [
        readOnly
            ? Container(
                height: screen.height,
                foregroundDecoration: const BoxDecoration(
                  color: CustomColors.disactive,
                ),
              )
            : const SizedBox(),
        Column(
          children: [
            ClipPath(
              clipper: OvalBC(),
              child: Container(
                height: screen.height / 4.5,
                color: CustomColors.oliveSoso,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: screen.width * 0.05),
              child: _NameInput(
                selection: selection,
                readOnly: readOnly,
              ),
            ),
            _SelectionPhotoWidget(
              selection: selection,
              talesList: talesList,
              readOnly: readOnly,
              route: route,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _AudiolistSelectAudioWidget(
                  selection: selection,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _NameInput extends StatelessWidget {
  const _NameInput({
    Key? key,
    required this.selection,
    required this.readOnly,
  }) : super(key: key);
  final Selection? selection;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    final SelectionsBloc _selectionsBloc =
        BlocProvider.of<SelectionsBloc>(context);
    Size screen = MediaQuery.of(context).size;
    return TextFormField(
      readOnly: readOnly,
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      initialValue: readOnly
          ? selection?.name
          : _selectionsBloc.changeSelectionService.name,
      onChanged: (value) {
        if (readOnly) {
          return;
        }
        _selectionsBloc.add(ChangeSelectionNameEvent(
          value: value,
        ));
      },
      style: TextStyle(
        color: CustomColors.white,
        fontSize: screen.width * 0.055,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _SelectionPhotoWidget extends StatefulWidget {
  const _SelectionPhotoWidget({
    Key? key,
    required this.selection,
    required this.talesList,
    required this.readOnly,
    required this.route,
  }) : super(key: key);
  final String route;
  final Selection? selection;
  final bool readOnly;
  final List<AudioTale> talesList;

  @override
  State<_SelectionPhotoWidget> createState() => _SelectionPhotoWidgetState();
}

class _SelectionPhotoWidgetState extends State<_SelectionPhotoWidget> {
  @override
  Widget build(BuildContext context) {
    final SelectionsBloc _selectionsBloc =
        BlocProvider.of<SelectionsBloc>(context);
    Size screen = MediaQuery.of(context).size;
    DecorationImage? _decorationImageReadOnly() {
      if (widget.selection?.photo != null) {
        try {
          return DecorationImage(
              image: MemoryImage(
                  File(widget.selection?.photo ?? '').readAsBytesSync()),
              fit: BoxFit.cover);
        } catch (_) {}
      }

      if (widget.selection?.photoUrl != null) {
        try {
          return DecorationImage(
            image: CachedNetworkImageProvider(widget.selection?.photoUrl ?? ''),
            fit: BoxFit.cover,
          );
        } catch (_) {
          return null;
        }
      }
      return null;
    }

    DecorationImage? _decorationImage() {
      if (_selectionsBloc.changeSelectionService.photo != null) {
        try {
          return DecorationImage(
              image: MemoryImage(
                  File(_selectionsBloc.changeSelectionService.photo!)
                      .readAsBytesSync()),
              fit: BoxFit.cover);
        } catch (_) {}
      }
      if (widget.selection?.photoUrl != null) {
        try {
          return DecorationImage(
            image: CachedNetworkImageProvider(widget.selection?.photoUrl ?? ''),
            fit: BoxFit.cover,
          );
        } catch (_) {
          return null;
        }
      }
      return null;
    }

    return Container(
        width: screen.width * 0.92,
        height: screen.height * 0.25,
        decoration: BoxDecoration(
          image:
              widget.readOnly ? _decorationImageReadOnly() : _decorationImage(),
          boxShadow: const [
            BoxShadow(
                color: CustomColors.boxShadow, spreadRadius: 3, blurRadius: 10)
          ],
          color: CustomColors.whiteOp,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(screen.width * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: screen.height * 0.05,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _DateSelectionScreen(selection: widget.selection!),
                    const SizedBox(),
                  ],
                ),
              ),
              SizedBox(
                height: screen.height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    WrapSelectionsListTextData(selection: widget.selection!),
                    widget.talesList.isNotEmpty &&
                            widget.route == '/selection_screen.dart'
                        ? PlayAllTalesButtonWidget(
                            talesList: widget.talesList,
                            textColor: CustomColors.white,
                            backgroundColor:
                                CustomColors.playAllButtonDisactive,
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class _AudiolistSelectAudioWidget extends StatefulWidget {
  const _AudiolistSelectAudioWidget({
    Key? key,
    required this.selection,
  }) : super(key: key);
  final Selection selection;

  @override
  State<_AudiolistSelectAudioWidget> createState() =>
      _AudiolistSelectAudioWidgetState();
}

class _AudiolistSelectAudioWidgetState
    extends State<_AudiolistSelectAudioWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectionsBloc, SelectionsState>(
      builder: (context, state) {
        final Size screen = MediaQuery.of(context).size;
        final SelectionsBloc _selectionsBloc =
            BlocProvider.of<SelectionsBloc>(context);
        final List<AudioTale> _talesList =
            RepositoryProvider.of<TalesListRepository>(context)
                .getTalesListRepository()
                .getCompilation(id: widget.selection.id);
        List<String> checkedList =
            _selectionsBloc.changeSelectionService.checkedList;
        return SizedBox(
          height: screen.height * 0.7,
          child: ListView.builder(
            itemCount: _talesList.length,
            itemBuilder: (_, i) {
              bool isChecked = checkedList.contains(_talesList.elementAt(i).id);
              return Padding(
                padding: EdgeInsets.all(screen.height * 0.005),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              CustomIconsImg.playSVG,
                              color: CustomColors.oliveSoso,
                            ),
                            iconSize: screen.height * 0.05,
                          ),
                          SizedBox(
                            width: screen.width * 0.05,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_talesList.elementAt(i).name),
                              _AudioListText(audio: _talesList.elementAt(i)),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          _selectionsBloc.add(
                            CheckEvent(
                              isChecked: isChecked,
                              id: _talesList.elementAt(i).id,
                            ),
                          );
                          setState(() {});
                        },
                        icon: isChecked
                            ? SvgPicture.asset(
                                CustomIconsImg.check,
                                height: screen.height * 0.055,
                                color: CustomColors.black,
                              )
                            : SvgPicture.asset(
                                CustomIconsImg.uncheck,
                                height: screen.height * 0.055,
                                color: CustomColors.black,
                              ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: CustomColors.white,
                    border: Border.all(color: CustomColors.audioBorder),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(41),
                    ),
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

class _AudioListText extends StatelessWidget {
  const _AudioListText({
    Key? key,
    required this.audio,
  }) : super(key: key);
  final AudioTale audio;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenBloc, MainScreenState>(
      buildWhen: (previous, current) {
        return previous.readOnly != current.readOnly;
      },
      builder: (context, state) {
        String text = TimeTextConvertService.instance
            .getConvertedMinutesText(timeInMinutes: audio.time);

        return audio.id != state.chahgedAudioId
            ? Text(
                '${audio.time.round()} $text',
                style: const TextStyle(
                  color: CustomColors.noTalesText,
                  fontFamily: 'TT Norms',
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                ),
              )
            : const SizedBox();
      },
    );
  }
}

class _TitleSelectionScreen extends StatelessWidget {
  const _TitleSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('');
  }
}

class _DateSelectionScreen extends StatelessWidget {
  const _DateSelectionScreen({
    Key? key,
    required this.selection,
  }) : super(key: key);

  final Selection selection;

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    String text = TimeTextConvertService.instance.dayMonthYear(selection.date);
    return Text(
      text,
      style: TextStyle(
          color: CustomColors.white,
          fontSize: screen.height * 0.01,
          fontWeight: FontWeight.bold),
    );
  }
}
