import 'package:flutter/material.dart';

import '../../texts/cancel_record_button_text.dart';

class CancelRecordButton extends StatelessWidget {
  const CancelRecordButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: () {}, child: const CancelRecordButtonText());
  }
}
