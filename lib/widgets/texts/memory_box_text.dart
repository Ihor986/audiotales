import 'package:flutter/material.dart';

class MamoryBox extends StatelessWidget {
  const MamoryBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: memoryBox()),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(),
            youWoiceAllwaysNear(),
          ],
        )
      ],
    );
  }
}

Text memoryBox() => const Text(
      'MemoryBox',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontStyle: FontStyle.normal,
        fontSize: 48,
      ),
    );
Text youWoiceAllwaysNear() => const Text(
      'твой голос всегда рядом',
      textAlign: TextAlign.end,
      style: TextStyle(
        // fontWeight: FontWeight.bold,
        color: Colors.white,
        fontStyle: FontStyle.normal,
        fontSize: 14,
      ),
    );
