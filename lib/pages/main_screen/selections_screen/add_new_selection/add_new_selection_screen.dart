import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../models/selections.dart';
import '../../../../models/tales_list.dart';
import '../../../../repositorys/selections_repositiry.dart';
import '../../../../repositorys/tales_list_repository.dart';
import '../../../../utils/custom_colors.dart';
import '../../../../utils/custom_icons.dart';
import '../bloc/selections_bloc.dart';
import '../widgets/selection_screen_body.dart';
import 'add_new_selections_text.dart';

class AddNewSelectionScreen extends StatelessWidget {
  const AddNewSelectionScreen({Key? key}) : super(key: key);
  static const routeName = '/add_new_selection_screen.dart';

  @override
  Widget build(BuildContext context) {
    // Size screen = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: _appBar(context),
      body: const BodySelectionScreen(
        selection: null,
        readOnly: false,
      ),

      //  Stack(
      //   children: [
      //     Column(
      //       children: [
      //         ClipPath(
      //           clipper: OvalBC(),
      //           child: Container(
      //             height: screen.height / 4.5,
      //             color: CustomColors.oliveSoso,
      //           ),
      //         ),
      //       ],
      //     ),
      //     Padding(
      //       padding: EdgeInsets.only(left: screen.width * 0.05),
      //       child: const _AddNewSelectionsNameInput(),
      //     ),
      //     const Align(
      //         alignment: Alignment(0, -0.8),
      //         child: _AddNewSelectionPhotoWidget()),
      //     // const Align(
      //     //     alignment: Alignment(-0.85, -0.2),
      //     //     child: AddNewSelectionsTextDescription()),
      //     const Align(
      //         alignment: Alignment(0, -0.05), child: _AddNewSelectionsInput()),
      //     const Align(
      //         alignment: Alignment(0, 0.4),
      //         child: AddNewSelectionsTextAddAudio()),
      //   ],
      // ),
    );
  }
}

AppBar _appBar(BuildContext context) {
  const AddNewSelectionsText title = AddNewSelectionsText();
  Size screen = MediaQuery.of(context).size;
  final SelectionsBloc _selectionsBloc =
      BlocProvider.of<SelectionsBloc>(context);
  final TalesList _taleList =
      RepositoryProvider.of<TalesListRepository>(context)
          .getTalesListRepository();
  final SelectionsList _selectionsList =
      RepositoryProvider.of<SelectionsListRepository>(context)
          .getSelectionsListRepository();

  return AppBar(
    actions: <Widget>[
      Padding(
        padding: EdgeInsets.only(right: screen.width * 0.04),
        child: TextButton(
          child: const AddNewSelectionsTextReady(),
          onPressed: () {
            _selectionsBloc.add(
              SaveCreatedSelectionEvent(
                  talesList: _taleList, selectionsList: _selectionsList),
            );
            Navigator.pop(context);
          },
        ),
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
        Navigator.pop(context);
      },
    ),
    title: title,
  );
}

// class _AddNewSelectionsInput extends StatefulWidget {
//   const _AddNewSelectionsInput({Key? key}) : super(key: key);

//   @override
//   State<_AddNewSelectionsInput> createState() => _AddNewSelectionsInputState();
// }

// class _AddNewSelectionsInputState extends State<_AddNewSelectionsInput> {
//   bool readOnly = false;
//   TextEditingController? _controller;
//   @override
//   Widget build(BuildContext context) {
//     Size screen = MediaQuery.of(context).size;

//     final SelectionsBloc _selectionsBloc =
//         BlocProvider.of<SelectionsBloc>(context);
//     return SizedBox(
//       height: screen.height * 0.20,
//       child: Column(
//         // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         // crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Padding(
//             padding: EdgeInsets.only(
//                 left: screen.width * 0.04, right: screen.width * 0.04),
//             child: TextFormField(
//               controller: _controller,
//               // maxLength: 500,
//               decoration: InputDecoration(
//                 hintText: TextsConst.addNewSelectionsTextEnterDescription,
//                 hintStyle: TextStyle(
//                     color: CustomColors.black, fontSize: screen.width * 0.033),
//                 // isDense: false,
//               ),
//               readOnly: readOnly,
//               onChanged: (value) {
//                 _selectionsBloc
//                     .add(CreateSelectionDescriptionEvent(value: value));
//               },
//               keyboardType: TextInputType.multiline, //
//               maxLines: 4,
//             ),
//           ),
//           Align(
//             alignment: const Alignment(1, 0),
//             child: TextButton(
//               onPressed: () {
//                 setState(() {
//                   readOnly = !readOnly;
//                 });
//               },
//               child: Text(
//                 TextsConst.addNewSelectionsTextReady,
//                 style: TextStyle(
//                     color: CustomColors.black, fontSize: screen.width * 0.03),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _AddNewSelectionPhotoWidget extends StatefulWidget {
//   const _AddNewSelectionPhotoWidget({Key? key}) : super(key: key);

//   @override
//   State<_AddNewSelectionPhotoWidget> createState() =>
//       _AddNewSelectionPhotoWidgetState();
// }

// class _AddNewSelectionPhotoWidgetState
//     extends State<_AddNewSelectionPhotoWidget> {
//   @override
//   Widget build(BuildContext context) {
//     final SelectionsBloc _selectionsBloc =
//         BlocProvider.of<SelectionsBloc>(context);

//     Size screen = MediaQuery.of(context).size;
//     return Container(
//       width: screen.width * 0.92,
//       height: screen.height * 0.25,
//       decoration: BoxDecoration(
//         image: _selectionsBloc.changeSelectionService.photo != null
//             ? DecorationImage(
//                 image: MemoryImage(
//                     File(_selectionsBloc.changeSelectionService.photo!)
//                         .readAsBytesSync()),
//                 fit: BoxFit.cover)
//             : null,
//         boxShadow: const [
//           BoxShadow(
//               color: CustomColors.boxShadow, spreadRadius: 3, blurRadius: 10)
//         ],
//         color: CustomColors.whiteOp,
//         borderRadius: const BorderRadius.all(
//           Radius.circular(15),
//         ),
//       ),
//       child:
//           //  _selectionsBloc.addAudioToSelectionService.photo == null
//           //     ?
//           IconButton(
//         onPressed: () async {
//           _selectionsBloc.changeSelectionService.photo =
//               await ImageServise().pickImageToSelection();
//           setState(() {});
//         },
//         icon: const ImageIcon(
//           CustomIconsImg.emptyfoto,
//           color: CustomColors.iconsColorPlayRecUpbar,
//           size: 50,
//         ),
//       ),
//       // : null,
//     );
//   }
// }

// class _AddNewSelectionsNameInput extends StatelessWidget {
//   const _AddNewSelectionsNameInput({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final SelectionsBloc _selectionsBloc =
//         BlocProvider.of<SelectionsBloc>(context);
//     Size screen = MediaQuery.of(context).size;
//     return TextFormField(
//       decoration: const InputDecoration(
//         border: InputBorder.none,
//       ),
//       initialValue: _selectionsBloc.changeSelectionService.name,
//       onChanged: (value) {
//         _selectionsBloc.add(CreateSelectionNameEvent(value: value));
//       },
//       style: TextStyle(
//         color: CustomColors.white,
//         fontSize: screen.width * 0.055,
//         fontWeight: FontWeight.bold,
//       ),
//     );
//   }
// }
