import 'package:audiotales/models/tales_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../models/selections.dart';
import '../../../../../repositorys/selections_repositiry.dart';
import '../../../../../utils/consts/custom_colors.dart';
import '../../../../../utils/consts/custom_icons_img.dart';
import '../../../../repositorys/tales_list_repository.dart';
import '../../main_screen_block/main_screen_bloc.dart';
import '../add_new_selection/add_new_selections_text.dart';
import '../bloc/selections_bloc.dart';
import '../selection_select_few_screen/selection_select_few_screen.dart';
import '../wiget/selection_screen_body.dart';
import 'selection_screen_widgets/text_selection_screen.dart';

class SelectionScreenPageArguments {
  SelectionScreenPageArguments({
    required this.selection,
  });

  final Selection selection;
}

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({
    Key? key,
    required this.selection,
  }) : super(key: key);
  static const routeName = '/selection_screen.dart';
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
          body: BodySelectionScreen(
            selection: selection,
            readOnly: _selectionsBloc.changeSelectionService.readOnly,
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
    // return BlocBuilder<SelectionsBloc, SelectionsState>(
    //   builder: (context, state) {
    Size screen = MediaQuery.of(context).size;
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
                  child: const Text('Редактировать'),
                  value: () {
                    _selectionsBloc.add(EditAllSelection(
                      selection: selection,
                    ));
                  },
                ),
                PopupMenuItem(
                  child: const Text('Выбрать несколько'),
                  value: () {
                    _selectionsBloc.changeSelectionService.dispouse();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectionSelectFewScreen(
                          selection: selection,
                        ),
                      ),
                      (_) => true,
                    );
                  },
                ),
                PopupMenuItem(
                  child: const Text('Удалить подборку'),
                  value: () {
                    _selectionsBloc.add(DeleteSelectionEvent(
                      selection: selection,
                      selectionsList: _selectionsList,
                      talesList: talesList,
                    ));
                    Navigator.pop(context);
                  },
                ),
                PopupMenuItem(
                  child: const Text('Поделиться'),
                  value: () {
                    context.read<MainScreenBloc>().add(
                          ShareAudiosEvent(
                            audioList:
                                talesList.getCompilation(id: selection.id),
                            name: selection.name,
                          ),
                        );
                  },
                ),
              ],
              onSelected: (Function value) {
                value();
              },
            ),
            // IconButton(
            //   icon: const ImageIcon(CustomIconsImg.moreHorizRounded),
            //   onPressed: () {},
            // ),
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
                // talesList: _taleList,
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

// Widget _Action(
//   // bool readOnly,
//   BuildContext context,
// ) {
 
//   Size screen = MediaQuery.of(context).size;
  
// }




// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../models/audio.dart';
// import '../../../../models/selections.dart';
// import '../../../../repositorys/tales_list_repository.dart';
// import '../../../../utils/consts/custom_colors.dart';
// import '../../../../utils/consts/custom_icons_img.dart';
// import '../../../../widgets/uncategorized/play_all_button.dart';
// import '../../../../widgets/uncategorized/tales_list_widget.dart';
// import '../../../../widgets/uncategorized/custom_clipper_widget.dart';
// import '../selections_text.dart';
// import 'selection_screen_widgets/text_selection_screen.dart';

// class SelectionScreenPageArguments {
//   SelectionScreenPageArguments({
//     required this.selection,
//   });

//   final Selection selection;
// }

// class SelectionScreen extends StatelessWidget {
//   const SelectionScreen({
//     Key? key,
//     required this.selection,
//   }) : super(key: key);
//   static const routeName = '/selection_screen.dart';
//   final Selection selection;
//   @override
//   Widget build(BuildContext context) {
//     final List<AudioTale> talesList =
//         RepositoryProvider.of<TalesListRepository>(context)
//             .getTalesListRepository()
//             .getCompilation(selection.id);
//     Size screen = MediaQuery.of(context).size;

//     return Scaffold(
//       extendBody: true,
//       appBar: _appBar(context),
//       body: Stack(
//         children: [
//           ClipPath(
//             clipper: OvalBC(),
//             child: Container(
//               height: screen.height / 4.5,
//               color: CustomColors.oliveSoso,
//             ),
//           ),
//           Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(left: screen.width * 0.05),
//                 child: _SelectionNameInput(
//                   selection: selection,
//                 ),
//               ),
//               _SelectionPhotoWidget(
//                 selection: selection,
//                 talesList: talesList,
//               ),
//               _SelectionDescriptionInput(
//                 selection: selection,
//               ),
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: TalesListWidget(
//                     talesList: talesList,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// AppBar _appBar(BuildContext context) {
//   const TitleSelectionScreen title = TitleSelectionScreen();
//   Size screen = MediaQuery.of(context).size;

//   return AppBar(
//     actions: <Widget>[
//       Padding(
//         padding: EdgeInsets.only(right: screen.width * 0.04),
//         child: Column(
//           children: [
//             IconButton(
//               icon: const ImageIcon(CustomIconsImg.moreHorizRounded),
//               // tooltip: 'Open shopping cart',
//               onPressed: () {},
//             ),
//             const SizedBox(),
//           ],
//         ),
//       ),
//     ],
//     backgroundColor: CustomColors.oliveSoso,
//     centerTitle: true,
//     elevation: 0,
//     leading: Padding(
//       padding: EdgeInsets.only(
//         top: screen.width * 0.02,
//         left: screen.width * 0.04,
//         bottom: screen.width * 0.02,
//       ),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           color: CustomColors.white,
//         ),
//         child: IconButton(
//           icon: const ImageIcon(
//             CustomIconsImg.arrowLeftCircle,
//             color: CustomColors.black,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//     ),
//     title: title,
//   );
// }

// class _SelectionDescriptionInput extends StatefulWidget {
//   const _SelectionDescriptionInput({
//     Key? key,
//     required this.selection,
//   }) : super(key: key);
//   final Selection selection;

//   @override
//   State<_SelectionDescriptionInput> createState() =>
//       _SelectionDescriptionInputState();
// }

// class _SelectionDescriptionInputState
//     extends State<_SelectionDescriptionInput> {
//   int? maxLines = 2;

//   @override
//   Widget build(BuildContext context) {
//     Size screen = MediaQuery.of(context).size;
//     String text = widget.selection.description ?? '';
//     bool isTextToLength = text.length > 75 && maxLines == 2;

//     return GestureDetector(
//       behavior: HitTestBehavior.opaque,
//       child: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(
//                 left: screen.width * 0.04, right: screen.width * 0.04),
//             child: isTextToLength
//                 ? _TextForm(
//                     description: text.substring(0, 75) + '...',
//                     maxLines: maxLines,
//                   )
//                 : Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: _FullTextForm(
//                       description: widget.selection.description ?? '',
//                       // description: text.substring(0, 700),
//                     ),
//                   ),
//           ),
//           isTextToLength ? const Text('Detales') : const SizedBox(),
//         ],
//       ),
//       onTap: () {
//         if (maxLines == 2) {
//           maxLines = 20;
//         } else {
//           maxLines = 2;
//         }
//         setState(() {});
//       },
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
//         height: screen.height * 0.5,
//         child: SingleChildScrollView(child: Text(description)),
//       );
//     } else {
//       return Text(description);
//     }
//   }
// }

// class _SelectionPhotoWidget extends StatelessWidget {
//   const _SelectionPhotoWidget({
//     Key? key,
//     required this.selection,
//     required this.talesList,
//   }) : super(key: key);

//   final Selection selection;
//   final List<AudioTale> talesList;

//   @override
//   Widget build(BuildContext context) {
//     Size screen = MediaQuery.of(context).size;
//     DecorationImage? decorationImage() {
//       if (selection.photo != null) {
//         try {
//           return DecorationImage(
//               image: MemoryImage(File(selection.photo ?? '').readAsBytesSync()),
//               fit: BoxFit.cover);
//         } catch (_) {}
//       }

//       if (selection.photoUrl != null) {
//         try {
//           return DecorationImage(
//             image: NetworkImage(selection.photoUrl ?? ''),
//             fit: BoxFit.cover,
//           );
//         } catch (_) {
//           return null;
//         }
//       }
//       return null;
//     }

//     return Container(
//       width: screen.width * 0.92,
//       height: screen.height * 0.25,
//       decoration: BoxDecoration(
//         image: decorationImage(),
//         boxShadow: const [
//           BoxShadow(
//               color: CustomColors.boxShadow, spreadRadius: 3, blurRadius: 10)
//         ],
//         color: CustomColors.iconsColorBNB,
//         borderRadius: const BorderRadius.all(
//           Radius.circular(15),
//         ),
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(screen.width * 0.04),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             SizedBox(
//               height: screen.height * 0.05,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   DateSelectionScreen(selection: selection),
//                   const SizedBox(),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: screen.height * 0.1,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   WrapSelectionsListTextData(selection: selection),
//                   talesList.isNotEmpty
//                       ? PlayAllTalesButtonWidget(
//                           talesList: talesList,
//                           textColor: CustomColors.white,
//                           backgroundColor: CustomColors.playAllButtonDisactive,
//                         )
//                       : const SizedBox(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _SelectionNameInput extends StatelessWidget {
//   const _SelectionNameInput({
//     Key? key,
//     required this.selection,
//   }) : super(key: key);

//   final Selection selection;

//   @override
//   Widget build(BuildContext context) {
//     Size screen = MediaQuery.of(context).size;
//     return TextFormField(
//       decoration: const InputDecoration(
//         border: InputBorder.none,
//       ),
//       initialValue: selection.name,
//       onChanged: (value) {},
//       readOnly: true,
//       style: TextStyle(
//         color: CustomColors.white,
//         fontSize: screen.width * 0.055,
//         fontWeight: FontWeight.bold,
//       ),
//     );
//   }
// }
