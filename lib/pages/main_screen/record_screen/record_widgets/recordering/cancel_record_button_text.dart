import 'package:flutter/material.dart';

import '../../../../../utils/texts_consts.dart';

class CancelRecordButtonText extends StatelessWidget {
  const CancelRecordButtonText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size screen = MediaQuery.of(context).size;
    return const Text(
      TextsConst.cancel,
      style: TextStyle(
        color: Colors.black,
        fontStyle: FontStyle.normal,
        fontSize: 14,
      ),
    );
  }
}
