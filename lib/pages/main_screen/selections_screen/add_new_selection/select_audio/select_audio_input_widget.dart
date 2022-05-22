import 'package:flutter/material.dart';

import '../../../../../utils/consts/custom_colors.dart';
import '../../../../../utils/consts/custom_icons_img.dart';
import '../../../../../utils/consts/texts_consts.dart';

class SelectAudioSearchWidget extends StatelessWidget {
  const SelectAudioSearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: CustomColors.white,
          boxShadow: const [
            BoxShadow(
              color: CustomColors.boxShadow,
              offset: Offset(0, 5),
              blurRadius: 6,
            ),
          ],
          borderRadius: BorderRadius.circular(41),
        ),
        width: 309,
        height: 59,
        child: TextFormField(
          autofocus: false,
          onChanged: (value) {},
          textAlign: TextAlign.start,
          cursorRadius: const Radius.circular(41.0),
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(20),
            hintText: TextsConst.search,
            hintStyle: TextStyle(color: CustomColors.noTalesText),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(41.0)),
                borderSide: BorderSide(
                    color: Color.fromRGBO(246, 246, 246, 1), width: 2.0)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(41.0)),
                borderSide: BorderSide(
                    color: Color.fromRGBO(246, 246, 246, 1), width: 2.0)),
            suffixIcon: Padding(
              padding: EdgeInsets.only(right: 20),
              child: ImageIcon(
                CustomIconsImg.search,
                // size: 1,
                color: CustomColors.black,
              ),
            ),
            suffixIconColor: CustomColors.black,
            // suffixStyle:
          ),
        ));
  }
}
