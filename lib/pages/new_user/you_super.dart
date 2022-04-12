import 'dart:async';
import 'package:flutter/material.dart';
import '../../utils/consts/colors.dart';
import '../../widgets/texts/start_regular_user_text.dart';
import '../../widgets/texts/you_super_text.dart';
import '../../widgets/uncategorized/custom_clipper_widget.dart';
import '../head_screen/head_screen.dart';

class YouSuperPage extends StatefulWidget {
  const YouSuperPage({Key? key}) : super(key: key);
  static const routeName = '/new_user/you_super.dart';

  @override
  State<YouSuperPage> createState() => _YouSuperPageState();
}

class _YouSuperPageState extends State<YouSuperPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
        HeadScreen.routeName,
        (_) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // num screenWidth = MediaQuery.of(context).size.width;
    num screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: blueSoso,
        elevation: 0,
      ),
      body: Column(
        children: [
          ClipPath(
            clipper: OvalBC(),
            child: Container(
              height: screenHeight / 4.5,
              color: blueSoso,
              child: const YouSuper(),
            ),
          ),
          const StartRegularUserText1(),
        ],
      ),
    );
  }
}
