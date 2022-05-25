import 'package:audiotales/utils/consts/custom_colors.dart';
import 'package:flutter/material.dart';

import '../../../../utils/consts/texts_consts.dart';

class AddNewSelectionsInput extends StatelessWidget {
  const AddNewSelectionsInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return SizedBox(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextFormField(),
          TextButton(
            onPressed: () {},
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
