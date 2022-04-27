import 'package:flutter/material.dart';

import '../../utils/consts/texts_consts.dart';

class RecordText extends StatelessWidget {
  const RecordText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    num screenHeight = MediaQuery.of(context).size.height;
    return const Text(TextsConst.record,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ));
  }
}
