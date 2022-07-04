import 'dart:io';
// import 'package:audiotales/pages/main_screen/selections_screen/selection_screen.dart/selection_screen_widgets/text_selection_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../models/audio.dart';
import '../../../../models/selections.dart';
import '../../../../models/tales_list.dart';
import '../../../../repositorys/tales_list_repository.dart';
import '../../../../services/image_service.dart';
import '../../../../services/sound_service.dart';
import '../../../../utils/consts/custom_colors.dart';
import '../../../../utils/consts/custom_icons_img.dart';
import '../../../../utils/consts/texts_consts.dart';
import '../../../../widgets/texts/audio_list_text/audio_list_text.dart';
import '../../../../widgets/uncategorized/active_tales_list_widget.dart';
import '../../../../widgets/uncategorized/custom_clipper_widget.dart';
import '../../../../widgets/uncategorized/player_widget.dart';
import '../../audios_screen/bloc/audio_screen_bloc.dart';
import '../../main_screen_block/main_screen_bloc.dart';
import '../add_new_selection/add_new_selections_text.dart';
import '../bloc/selections_bloc.dart';
import '../selection_screen/selection_screen_widgets/text_selection_screen.dart';
import '../selections_screen.dart';
import '../selections_text.dart';

class BodySelectionScreen extends StatelessWidget {
  const BodySelectionScreen({
    Key? key,
    required this.selection,
    required this.readOnly,
  }) : super(key: key);
  final Selection? selection;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    final List<AudioTale> talesList;
    if (selection != null) {
      talesList = RepositoryProvider.of<TalesListRepository>(context)
          .getTalesListRepository()
          .getCompilation(id: selection!.id);
    } else {
      talesList = [];
    }

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
            ),
            _SelectionDescriptionInput(
              selection: selection,
              readOnly: readOnly,
            ),
            selection == null
                ? Align(
                    alignment: const Alignment(0, 1),
                    child: SizedBox(
                      height: screen.height * 0.25,
                      child: const AddNewSelectionsTextAddAudio(),
                    ),
                  )
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      // child: ActiveTalesListWidget(
                      //   color: CustomColors.oliveSoso,
                      // ),
                      child: _TalesListWidget(
                        selection: selection,
                        isDisactive: !readOnly,
                        color: CustomColors.oliveSoso,
                        icon: CustomIconsImg.moreHorizontRounded,
                      ),
                    ),
                  ),
          ],
        ),
        const PlayerWidget(),
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
          // readOnly:readOnly,
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
  }) : super(key: key);
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
      child: widget.readOnly
          ? Padding(
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
                        DateSelectionScreen(selection: widget.selection!),
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
                        WrapSelectionsListTextData(
                            selection: widget.selection!),
                        widget.talesList.isNotEmpty
                            ? _PlayAllTalesButtonWidget(
                                talesList: widget.talesList,
                                textColor: CustomColors.white,
                                backgroundColor:
                                    CustomColors.playAllButtonDisactive,
                                selection: widget.selection,
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : IconButton(
              onPressed: () async {
                _selectionsBloc.changeSelectionService.photo =
                    await ImageServise().pickImageToCasheMemory();
                setState(() {});
              },
              icon: const ImageIcon(
                CustomIconsImg.emptyfoto,
                color: CustomColors.iconsColorPlayRecUpbar,
                size: 50,
              ),
            ),
    );
  }
}

class _SelectionDescriptionInput extends StatefulWidget {
  const _SelectionDescriptionInput({
    Key? key,
    required this.selection,
    required this.readOnly,
  }) : super(key: key);
  final Selection? selection;
  final bool readOnly;

  @override
  State<_SelectionDescriptionInput> createState() =>
      _SelectionDescriptionInputState();
}

class _SelectionDescriptionInputState
    extends State<_SelectionDescriptionInput> {
  late bool readOnly;
  int? maxLines = 2;
  TextEditingController? _controller;

  @override
  Widget build(BuildContext context) {
    final SelectionsBloc _selectionsBloc =
        BlocProvider.of<SelectionsBloc>(context);
    Size screen = MediaQuery.of(context).size;
    readOnly = widget.readOnly;
    String text = widget.selection?.description ?? '';
    bool isTextToLength = text.length > 75 && maxLines == 2 && readOnly;
    bool isActiveInput = !readOnly && widget.selection != null;
    bool isNewSelection = widget.selection == null;

    //
    Widget textField() {
      if (isTextToLength) {
        return _TextForm(
          description: text.substring(0, 75) + '...',
          maxLines: maxLines,
        );
      }
      if (isNewSelection) {
        return _TextInput(
          controller: _controller,
          readOnly: widget.readOnly,
          description: _selectionsBloc.changeSelectionService.description,
        );
      }
      if (isActiveInput) {
        return _FullTextInput(
          controller: _controller,
          readOnly: widget.readOnly,
          description: _selectionsBloc.changeSelectionService.description,
        );
      }
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: _FullTextForm(
          description: widget.selection?.description ?? '',
          // description: text.substring(0, 700),
        ),
      );
    }

    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: screen.width * 0.04, right: screen.width * 0.04),
                child: textField(),
              ),
              isTextToLength ? const Text('Detales') : const SizedBox(),
            ],
          ),
          onTap: () {
            if (isActiveInput) {
              return;
            }
            if (maxLines == 2) {
              maxLines = 20;
            } else {
              maxLines = 2;
            }
            setState(() {});
          },
        ),
        isNewSelection
            ? Align(
                alignment: const Alignment(1, 0),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      // readOnly = !readOnly;
                    });
                  },
                  child: Text(
                    TextsConst.addNewSelectionsTextReady,
                    style: TextStyle(
                        color: CustomColors.black,
                        fontSize: screen.width * 0.03),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
    //   },
    // );
  }
}

class _TextForm extends StatelessWidget {
  const _TextForm({
    Key? key,
    required this.description,
    required this.maxLines,
  }) : super(key: key);
  final String? description;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: CustomColors.black),
      initialValue: description,
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      readOnly: true,
      onChanged: (value) {},
      keyboardType: TextInputType.multiline, //
      maxLines: maxLines,
      minLines: 2,
    );
  }
}

class _FullTextForm extends StatelessWidget {
  const _FullTextForm({
    Key? key,
    required this.description,
  }) : super(key: key);
  final String description;
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    if (description.length > 700) {
      return SizedBox(
        height: screen.height * 0.33,
        child: SingleChildScrollView(child: Text(description)),
      );
    } else {
      return Text(description);
    }
  }
}

class _TextInput extends StatelessWidget {
  const _TextInput({
    Key? key,
    required this.controller,
    required this.readOnly,
    required this.description,
  }) : super(key: key);
  final String? description;
  final TextEditingController? controller;
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    final SelectionsBloc _selectionsBloc =
        BlocProvider.of<SelectionsBloc>(context);
    return TextFormField(
      controller: controller,
      initialValue: description,
      decoration: InputDecoration(
        hintText: TextsConst.addNewSelectionsTextEnterDescription,
        hintStyle: TextStyle(
            color: CustomColors.black, fontSize: screen.width * 0.033),
        // isDense: false,
      ),
      readOnly: readOnly,
      onChanged: (value) {
        _selectionsBloc.add(ChangeSelectionDescriptionEvent(value: value));
      },
      keyboardType: TextInputType.multiline, //
      maxLines: 4,
    );
  }
}

class _FullTextInput extends StatelessWidget {
  const _FullTextInput({
    Key? key,
    required this.controller,
    required this.readOnly,
    required this.description,
  }) : super(key: key);
  final String? description;
  final TextEditingController? controller;
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    final SelectionsBloc _selectionsBloc =
        BlocProvider.of<SelectionsBloc>(context);
    return TextFormField(
      style: const TextStyle(color: CustomColors.black),
      initialValue: description,
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      readOnly: readOnly,
      onChanged: (value) {
        _selectionsBloc.add(ChangeSelectionDescriptionEvent(value: value));
      },
      keyboardType: TextInputType.multiline, //
      maxLines: 10,
      minLines: 1,
    );
  }
}

class _TalesListWidget extends StatelessWidget {
  const _TalesListWidget({
    Key? key,
    required this.selection,
    required this.color,
    required this.icon,
    // required this.onTap,
    this.isDisactive,
  }) : super(key: key);
  final Selection? selection;
  final bool? isDisactive;
  // final void Function() onTap;
  final String icon;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenBloc, MainScreenState>(
      builder: (context, state) {
        Size screen = MediaQuery.of(context).size;
        final TalesList _talesListRep =
            RepositoryProvider.of<TalesListRepository>(context)
                .getTalesListRepository();
        final List<AudioTale> talesList;
        if (selection != null) {
          talesList = _talesListRep.getCompilation(id: selection!.id);
        } else {
          talesList = [];
        }
        return ListView.builder(
          itemCount: talesList.length,
          itemBuilder: (_, i) {
            return Padding(
              padding: EdgeInsets.all(screen.height * 0.005),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        _PlayButton(
                          color: color,
                          i: i,
                          talesList: talesList,
                        ),
                        SizedBox(
                          width: screen.width * 0.05,
                        ),
                        SizedBox(
                          height: screen.height * 0.07,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AudioListNameText(
                                audio: talesList.elementAt(i),
                              ),
                              AudioListText(
                                audio: talesList.elementAt(i),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    isDisactive == false
                        ? PopupMenuButton(
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
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
                                  context
                                      .read<MainScreenBloc>()
                                      .add(ChangeAudioNameEvent(
                                        audio: talesList.elementAt(i),
                                      ));
                                },
                              ),
                              PopupMenuItem(
                                child: const Text('Добавить в подборку'),
                                value: () {
                                  context
                                      .read<SelectionsBloc>()
                                      .add(SelectSelectionsEvent(
                                        audio: talesList.elementAt(i),
                                      ));
                                  Navigator.pushNamed(
                                    context,
                                    SelectionsScreen.routeName,
                                  );
                                },
                              ),
                              PopupMenuItem(
                                child: const Text('Удалить '),
                                value: () {
                                  if (selection == null) return;
                                  context.read<SelectionsBloc>().add(
                                        RemoveFromSelectionEvent(
                                          audio: talesList.elementAt(i),
                                          talesList: _talesListRep,
                                          selectionId: selection!.id,
                                        ),
                                      );
                                },
                              ),
                              PopupMenuItem(
                                child: const Text('Поделиться'),
                                value: () {
                                  context.read<MainScreenBloc>().add(
                                        ShareAudioEvent(
                                          audio: talesList.elementAt(i),
                                        ),
                                      );
                                },
                              ),
                            ],
                            onSelected: (Function value) {
                              value();
                            },
                          )
                        : Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: SvgPicture.asset(
                              CustomIconsImg.moreHorizontRounded,
                              height: 3,
                              color: CustomColors.black,
                            ),
                          ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: CustomColors.white,
                  border: Border.all(color: CustomColors.audioBorder),
                  borderRadius: const BorderRadius.all(Radius.circular(41)),
                ),
                foregroundDecoration: isDisactive == true
                    ? BoxDecoration(
                        color: CustomColors.disactive,
                        border: Border.all(color: CustomColors.audioBorder),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(41)),
                      )
                    : null,
              ),
            );
          },
        );
      },
    );
  }
}

class _PlayButton extends StatelessWidget {
  const _PlayButton({
    Key? key,
    required this.i,
    required this.color,
    required this.talesList,
  }) : super(key: key);
  final List<AudioTale> talesList;
  final Color color;
  final int i;

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    final MainScreenBloc _mainScreenBloc = context.read<MainScreenBloc>();
    final String _id = talesList.elementAt(i).id;
    final FlutterSoundPlayer _player = _mainScreenBloc.sound.audioPlayer;
    return AnimatedBuilder(
      animation: _mainScreenBloc.sound,
      builder: (context, child) {
        return Column(
          children: [
            IconButton(
              onPressed: () {
                _mainScreenBloc.add(
                  ClickPlayEvent(
                    audioList: talesList,
                    indexAudio: i,
                  ),
                );
              },
              icon: _player.isPlaying && _id == _mainScreenBloc.sound.idPlaying
                  ? SvgPicture.asset(
                      CustomIconsImg.pauseAll,
                      color: color,
                    )
                  : SvgPicture.asset(
                      CustomIconsImg.playSVG,
                      color: color,
                    ),
              iconSize: screen.height * 0.05,
            ),
          ],
        );
      },
    );
  }
}

class _PlayAllTalesButtonWidget extends StatelessWidget {
  const _PlayAllTalesButtonWidget({
    Key? key,
    required this.talesList,
    required this.textColor,
    required this.backgroundColor,
    this.selection,
  }) : super(key: key);
  final Selection? selection;
  final List<AudioTale> talesList;
  final Color textColor;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    final SoundService _soundService =
        BlocProvider.of<MainScreenBloc>(context).sound;

    Size screen = MediaQuery.of(context).size;

    return AnimatedBuilder(
      animation: _soundService,
      builder: (context, child) {
        return Stack(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                _soundService.isRepeatAllList = false;
                context.read<AudioScreenBloc>().add(AudioScreenPlayAllEvent(
                      talesList: talesList,
                      selection: selection?.id,
                    ));
              },
              child: Container(
                height: screen.height * 0.05,
                width: screen.width * 0.41,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(screen.height * 0.005),
                      child: _soundService.audioPlayer.isPlaying &&
                              _soundService.isPlayingList == true &&
                              _soundService.idPlayingList == selection?.id
                          ? SvgPicture.asset(
                              CustomIconsImg.pauseAll,
                              color: textColor,
                              height: screen.height * 0.04,
                            )
                          : SvgPicture.asset(
                              CustomIconsImg.playSVG,
                              height: screen.height * 0.04,
                              color: textColor,
                            ),
                    ),
                    _soundService.audioPlayer.isPlaying &&
                            _soundService.isPlayingList == true &&
                            _soundService.idPlayingList == selection?.id
                        ? _AudioScreenPlayAllTextF(color: textColor)
                        : _AudioScreenPlayAllTextT(color: textColor),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _AudioScreenPlayAllTextT extends StatelessWidget {
  const _AudioScreenPlayAllTextT({Key? key, required this.color})
      : super(key: key);

  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(TextsConst.audioScreenPlayAllT, style: TextStyle(color: color));
  }
}

class _AudioScreenPlayAllTextF extends StatelessWidget {
  const _AudioScreenPlayAllTextF({Key? key, required this.color})
      : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(TextsConst.audioScreenPlayAllF, style: TextStyle(color: color));
  }
}
