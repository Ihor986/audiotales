import 'package:flutter/material.dart';

import '../../utils/consts/texts_consts.dart';

class YouSuper extends StatelessWidget {
  const YouSuper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: youSuper()),
      ],
    );
  }
}

Text youSuper() => const Text(
      TextsConst.youSuper,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontStyle: FontStyle.normal,
        fontSize: 48,
      ),
    );
