import 'dart:io';

import 'package:audiotales/models/tales_list.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../models/selections.dart';
import '../../../../../repositorys/selections_repositiry.dart';
import '../../../../../utils/consts/custom_colors.dart';
import '../../../../../utils/consts/custom_icons_img.dart';
import '../../../../models/audio.dart';
import '../../../../repositorys/tales_list_repository.dart';
import '../../../../services/image_service.dart';
import '../../../../utils/consts/texts_consts.dart';
import '../../../../widgets/texts/audio_list_text/audio_list_text.dart';
import '../../../../widgets/uncategorized/custom_clipper_widget.dart';
import '../../../../widgets/uncategorized/custom_popup_menu_active_playlist.dart';
import '../../../../widgets/uncategorized/play_all_button.dart';
import '../../main_screen_block/main_screen_bloc.dart';
import '../add_new_selection/add_new_selections_text.dart';
import '../bloc/selections_bloc.dart';
import '../selections_screen.dart';
import '../selections_text.dart';
import '../wiget/selection_screen_body.dart';
import 'selection_select_few_widgets/text_select_few_screen.dart';
// import 'selection_screen_widgets/text_selection_screen.dart';

// class SelectionScreenPageArguments {
//   SelectionScreenPageArguments({
//     required this.selection,
//   });

//   final Selection selection;
// }

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
        // Size screen = MediaQuery.of(context).size;

        return Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          appBar: _appBar(context, _selectionsBloc, selection),
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

AppBar _appBar(
    BuildContext context, SelectionsBloc selectionsBloc, Selection selection) {
  const TitleSelectionScreen title = TitleSelectionScreen();
  Size screen = MediaQuery.of(context).size;
  return AppBar(
    actions: <Widget>[
      _Action(
        selection: selection,
      ),
    ],
    backgroundColor: CustomColors.oliveSoso,
    centerTitle: true,
    elevation: 0,
    leading: Padding(
      padding: EdgeInsets.only(
        top: screen.width * 0.02,
        left: screen.width * 0.04,
        bottom: screen.width * 0.02,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: CustomColors.white,
        ),
        child: IconButton(
          icon: const ImageIcon(
            CustomIconsImg.arrowLeftCircle,
            color: CustomColors.black,
          ),
          onPressed: () {
            selectionsBloc.changeSelectionService.readOnly = true;
            Navigator.pop(context);
          },
        ),
      ),
    ),
    title: title,
  );
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
                            audioList: talesList.getCompilation(selection.id),
                            idList: _selectionsBloc
                                .changeSelectionService.checkedList,
                            name: selection.name,
                          ),
                        );
                  },
                ),
                PopupMenuItem(
                  child: const Text('Скачать все'),
                  value: () {},
                ),
                PopupMenuItem(
                  child: const Text('Удалить все'),
                  value: () {},
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
            // Navigator.pop(context);
          },
        ),
      );
    }
    //
    //   },
    // );
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
            .getCompilation(selection.id);

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
            // route == '/selection_select_few_screen.dart'
            //     ? const SizedBox()
            //     : _SelectionDescriptionInput(
            //         selection: selection,
            //         readOnly: readOnly,
            //       ),
            // selection == null
            //     ? Align(
            //         alignment: const Alignment(0, 1),
            //         child: SizedBox(
            //           height: screen.height * 0.25,
            //           child: const AddNewSelectionsTextAddAudio(),
            //         ),
            //       )
            //     :
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

class _AudiolistSelectAudioWidget extends StatelessWidget {
  const _AudiolistSelectAudioWidget({
    Key? key,
    required this.selection,
  }) : super(key: key);
  final Selection selection;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectionsBloc, SelectionsState>(
      builder: (context, state) {
        final Size screen = MediaQuery.of(context).size;
        final SelectionsBloc _selectionsBloc =
            BlocProvider.of<SelectionsBloc>(context);
        // final MainScreenBloc _mainScreenBloc =
        //     BlocProvider.of<MainScreenBloc>(context);
        final List<AudioTale> _talesList =
            RepositoryProvider.of<TalesListRepository>(context)
                .getTalesListRepository()
                .getCompilation(selection.id);
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
                            onPressed: () {
                              // _mainScreenBloc.add(ClickPlayEvent(_talesList.elementAt(i)));
                            },
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
                              AudioListText(audio: _talesList.elementAt(i)),
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

// class _SelectionDescriptionInput extends StatefulWidget {
//   const _SelectionDescriptionInput({
//     Key? key,
//     required this.selection,
  //   required this.readOnly,
  // }) : super(key: key);
  // final Selection? selection;
//   final bool readOnly;

//   @override
//   State<_SelectionDescriptionInput> createState() =>
//       _SelectionDescriptionInputState();
// }

// class _SelectionDescriptionInputState
//     extends State<_SelectionDescriptionInput> {
//   late bool readOnly;
//   int? maxLines = 2;
//   TextEditingController? _controller;

//   @override
//   Widget build(BuildContext context) {
//     final SelectionsBloc _selectionsBloc =
//         BlocProvider.of<SelectionsBloc>(context);
//     Size screen = MediaQuery.of(context).size;
//     readOnly = widget.readOnly;
//     String text = widget.selection?.description ?? '';
//     bool isTextToLength = text.length > 75 && maxLines == 2 && readOnly;
//     bool isActiveInput = !readOnly && widget.selection != null;
//     bool isNewSelection = widget.selection == null;

//     //
//     Widget textField() {
//       if (isTextToLength) {
//         return _TextForm(
//           description: text.substring(0, 75) + '...',
//           maxLines: maxLines,
//         );
//       }
//       if (isNewSelection) {
//         return _TextInput(
//           controller: _controller,
//           readOnly: widget.readOnly,
//           description: _selectionsBloc.changeSelectionService.description,
//         );
//       }
//       if (isActiveInput) {
//         return _FullTextInput(
//           controller: _controller,
//           readOnly: widget.readOnly,
//           description: _selectionsBloc.changeSelectionService.description,
//         );
//       }
//       return Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: _FullTextForm(
//           description: widget.selection?.description ?? '',
//           // description: text.substring(0, 700),
//         ),
//       );
//     }

//     return Column(
//       children: [
//         GestureDetector(
//           behavior: HitTestBehavior.opaque,
//           child: Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(
//                     left: screen.width * 0.04, right: screen.width * 0.04),
//                 child: textField(),
//               ),
//               isTextToLength ? const Text('Detales') : const SizedBox(),
//             ],
//           ),
//           onTap: () {
//             if (isActiveInput) {
//               return;
//             }
//             if (maxLines == 2) {
//               maxLines = 20;
//             } else {
//               maxLines = 2;
//             }
//             setState(() {});
//           },
//         ),
//         isNewSelection
//             ? Align(
//                 alignment: const Alignment(1, 0),
//                 child: TextButton(
//                   onPressed: () {
//                     setState(() {
//                       // readOnly = !readOnly;
//                     });
//                   },
//                   child: Text(
//                     TextsConst.addNewSelectionsTextReady,
//                     style: TextStyle(
//                         color: CustomColors.black,
//                         fontSize: screen.width * 0.03),
//                   ),
//                 ),
//               )
//             : const SizedBox(),
//       ],
//     );
//     //   },
//     // );
//   }
// }

// class _TextForm extends StatelessWidget {
//   const _TextForm({
//     Key? key,
//     required this.description,
//     required this.maxLines,
//   }) : super(key: key);
//   final String? description;
//   final int? maxLines;
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       style: const TextStyle(color: CustomColors.black),
//       initialValue: description,
//       decoration: const InputDecoration(
//         border: InputBorder.none,
//       ),
//       readOnly: true,
//       onChanged: (value) {},
//       keyboardType: TextInputType.multiline, //
//       maxLines: maxLines,
//       minLines: 2,
//     );
//   }
// }

// class _FullTextForm extends StatelessWidget {
//   const _FullTextForm({
//     Key? key,
//     required this.description,
//   }) : super(key: key);
//   final String description;
//   @override
//   Widget build(BuildContext context) {
//     Size screen = MediaQuery.of(context).size;
//     if (description.length > 700) {
//       return SizedBox(
//         height: screen.height * 0.33,
//         child: SingleChildScrollView(child: Text(description)),
//       );
//     } else {
//       return Text(description);
//     }
//   }
// }

// class _TextInput extends StatelessWidget {
//   const _TextInput({
//     Key? key,
//     required this.controller,
//     required this.readOnly,
//     required this.description,
//   }) : super(key: key);
//   final String? description;
//   final TextEditingController? controller;
//   final bool readOnly;
//   @override
//   Widget build(BuildContext context) {
//     Size screen = MediaQuery.of(context).size;
//     final SelectionsBloc _selectionsBloc =
//         BlocProvider.of<SelectionsBloc>(context);
//     return TextFormField(
//       controller: controller,
//       initialValue: description,
//       decoration: InputDecoration(
//         hintText: TextsConst.addNewSelectionsTextEnterDescription,
//         hintStyle: TextStyle(
//             color: CustomColors.black, fontSize: screen.width * 0.033),
//         // isDense: false,
//       ),
//       readOnly: readOnly,
//       onChanged: (value) {
//         _selectionsBloc.add(ChangeSelectionDescriptionEvent(value: value));
//       },
//       keyboardType: TextInputType.multiline, //
//       maxLines: 4,
//     );
//   }
// }

// class _FullTextInput extends StatelessWidget {
//   const _FullTextInput({
//     Key? key,
//     required this.controller,
//     required this.readOnly,
//     required this.description,
//   }) : super(key: key);
//   final String? description;
//   final TextEditingController? controller;
//   final bool readOnly;
//   @override
//   Widget build(BuildContext context) {
//     final SelectionsBloc _selectionsBloc =
//         BlocProvider.of<SelectionsBloc>(context);
//     return TextFormField(
//       style: const TextStyle(color: CustomColors.black),
//       initialValue: description,
//       decoration: const InputDecoration(
//         border: InputBorder.none,
//       ),
//       readOnly: readOnly,
//       onChanged: (value) {
//         _selectionsBloc.add(ChangeSelectionDescriptionEvent(value: value));
//       },
//       keyboardType: TextInputType.multiline, //
//       maxLines: 10,
//       minLines: 1,
//     );
//   }
// }

// class _TalesListWidget extends StatelessWidget {
//   const _TalesListWidget({
//     Key? key,
//     // required this.talesList,
//     required this.color,
//     required this.icon,
//     this.selection,
//     this.isDisactive,
//   }) : super(key: key);
//   final Selection? selection;
//   // final List<AudioTale> talesList;
//   final bool? isDisactive;
//   // final void Function() onTap;
//   final String icon;
//   final Color color;
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<MainScreenBloc, MainScreenState>(
//       builder: (context, state) {
//         Size screen = MediaQuery.of(context).size;
//         final List<AudioTale> _talesList = selection == null
//             ? RepositoryProvider.of<TalesListRepository>(context)
//                 .getTalesListRepository()
//                 .getActiveTalesList()
//             : RepositoryProvider.of<TalesListRepository>(context)
//                 .getTalesListRepository()
//                 .getCompilation(selection!.id);
//         final MainScreenBloc _mainScreenBloc =
//             BlocProvider.of<MainScreenBloc>(context);
//         return ListView.builder(
//           itemCount: _talesList.length,
//           // itemCount: 10,
//           itemBuilder: (_, i) {
//             return Padding(
//               padding: EdgeInsets.all(screen.height * 0.005),
//               child: Container(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         IconButton(
//                           onPressed: () {
//                             if (isDisactive == true) {
//                               return;
//                             }
//                             _mainScreenBloc
//                                 .add(ClickPlayEvent(_talesList.elementAt(i)));
//                           },
//                           icon: SvgPicture.asset(
//                             CustomIconsImg.playSVG,
//                             color: color,
//                           ),
//                           iconSize: screen.height * 0.05,
//                         ),
//                         SizedBox(
//                           width: screen.width * 0.05,
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(_talesList.elementAt(i).name),
//                             AudioListText(audio: _talesList.elementAt(i)),
//                           ],
//                         ),
//                       ],
//                     ),
//                     isDisactive == false
//                         ? CustomPopUpMenu(
//                             audio: _talesList.elementAt(i),
//                           )
//                         // PopupMenuButton(
//                         //     shape: const RoundedRectangleBorder(
//                         //       borderRadius:
//                         //           BorderRadius.all(Radius.circular(15)),
//                         //     ),
//                         //     icon: SvgPicture.asset(
//                         //       CustomIconsImg.moreHorizontRounded,
//                         //       height: 3,
//                         //       color: CustomColors.black,
//                         //     ),
//                         //     itemBuilder: (context) => [
//                         //       PopupMenuItem(
//                         //         child: const Text('Переименовать'),
//                         //         value: () {},
//                         //       ),
//                         //       PopupMenuItem(
//                         //         child: const Text('Добавить в подборку'),
//                         //         value: () {},
//                         //       ),
//                         //       PopupMenuItem(
//                         //         child: const Text('Удалить '),
//                         //         value: () {},
//                         //       ),
//                         //       PopupMenuItem(
//                         //         child: const Text('Поделиться'),
//                         //         value: () {},
//                         //       ),
//                         //     ],
//                         //     onSelected: (Function value) {
//                         //       value();
//                         //     },
//                         //   )
//                         : Padding(
//                             padding: const EdgeInsets.only(right: 20),
//                             child: SvgPicture.asset(
//                               CustomIconsImg.moreHorizontRounded,
//                               height: 3,
//                               color: CustomColors.black,
//                             ),
//                           ),
//                   ],
//                 ),
//                 decoration: BoxDecoration(
//                   color: CustomColors.white,
//                   border: Border.all(color: CustomColors.audioBorder),
//                   borderRadius: const BorderRadius.all(Radius.circular(41)),
//                 ),
//                 foregroundDecoration: isDisactive == true
//                     ? BoxDecoration(
//                         color: CustomColors.disactive,
//                         border: Border.all(color: CustomColors.audioBorder),
//                         borderRadius:
//                             const BorderRadius.all(Radius.circular(41)),
//                       )
//                     : null,
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
