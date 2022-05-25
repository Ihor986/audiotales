import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../utils/consts/custom_colors.dart';
import '../../../../../utils/consts/custom_icons_img.dart';
import '../../../../models/selections.dart';
import '../../../../repositorys/selections_repositiry.dart';
import '../../../../services/image_service.dart';
import '../bloc/selections_bloc.dart';

class AddNewSelectionPhotoWidget extends StatefulWidget {
  const AddNewSelectionPhotoWidget({Key? key}) : super(key: key);

  @override
  State<AddNewSelectionPhotoWidget> createState() =>
      _AddNewSelectionPhotoWidget();
}

class _AddNewSelectionPhotoWidget extends State<AddNewSelectionPhotoWidget> {
  @override
  Widget build(BuildContext context) {
    final SelectionsBloc _selectionsBloc =
        BlocProvider.of<SelectionsBloc>(context);

    Size screen = MediaQuery.of(context).size;
    return Container(
      width: screen.width * 0.92,
      height: screen.height * 0.25,
      decoration: BoxDecoration(
        image: _selectionsBloc.addAudioToSelectionService.photo != null
            ? DecorationImage(
                image: MemoryImage(
                    File(_selectionsBloc.addAudioToSelectionService.photo!)
                        .readAsBytesSync()),
                fit: BoxFit.cover)
            : null,
        boxShadow: const [
          BoxShadow(
              color: CustomColors.boxShadow, spreadRadius: 3, blurRadius: 10)
        ],
        color: CustomColors.whiteOp,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: _selectionsBloc.addAudioToSelectionService.photo == null
          ? IconButton(
              onPressed: () async {
                _selectionsBloc.addAudioToSelectionService.photo =
                    await ImageServise().pickImageToSelection();
                setState(() {});
              },
              icon: const ImageIcon(
                CustomIconsImg.emptyfoto,
                color: CustomColors.iconsColorPlayRecUpbar,
                size: 50,
              ),
            )
          : null,
    );
  }
}
