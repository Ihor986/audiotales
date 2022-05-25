import 'package:audiotales/utils/consts/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/consts/texts_consts.dart';
import '../bloc/selections_bloc.dart';

class AddNewSelectionsInput extends StatefulWidget {
  const AddNewSelectionsInput({Key? key}) : super(key: key);

  @override
  State<AddNewSelectionsInput> createState() => _AddNewSelectionsInputState();
}

class _AddNewSelectionsInputState extends State<AddNewSelectionsInput> {
  bool readOnly = false;
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    final SelectionsBloc _selectionsBloc =
        BlocProvider.of<SelectionsBloc>(context);
    return SizedBox(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: screen.width * 0.04, right: screen.width * 0.04),
            child: TextFormField(
              readOnly: readOnly,
              onChanged: (value) {
                _selectionsBloc
                    .add(CreateSelectionDescriptionEvent(value: value));
              },
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                readOnly = !readOnly;
              });
            },
            child: Text(
              TextsConst.addNewSelectionsTextReady,
              style: TextStyle(
                  color: CustomColors.black, fontSize: screen.width * 0.03),
            ),
          ),
        ],
      ),
    );
  }
}
