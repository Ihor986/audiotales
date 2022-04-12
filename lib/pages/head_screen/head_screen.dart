import 'package:flutter/material.dart';

import '../../utils/consts/colors.dart';

class HeadScreen extends StatelessWidget {
  const HeadScreen({Key? key}) : super(key: key);
  static const routeName = '/head_screen.dart';

  @override
  Widget build(BuildContext context) {
    num screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: blueSoso,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const Text('test'),
            ],
          ),
        ],
      ),
    );
  }
}
