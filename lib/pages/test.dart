import 'package:flutter/material.dart';

import '../utils/consts/custom_colors.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);
  static const routeName = '/test.dart';

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    // num screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: CustomColors.blueSoso,
        elevation: 0,
      ),
      body: Stack(
          // children: [
          // Column(
          //   children: [
          //     const Text('test'),
          //   ],
          // ),
          // ],
          ),
    );
  }
}
