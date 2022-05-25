import 'package:audiotales/utils/consts/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/consts/texts_consts.dart';
import '../bloc/selections_bloc.dart';

class AddNewSelectionsNameInput extends StatelessWidget {
  const AddNewSelectionsNameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SelectionsBloc _selectionsBloc =
        BlocProvider.of<SelectionsBloc>(context);
    Size screen = MediaQuery.of(context).size;
    return TextFormField(
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      initialValue: _selectionsBloc.addAudioToSelectionService.name,
      onChanged: (value) {
        _selectionsBloc.add(CreateSelectionNameEvent(value: value));
      },
      style: TextStyle(
        color: CustomColors.white,
        fontSize: screen.width * 0.055,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
