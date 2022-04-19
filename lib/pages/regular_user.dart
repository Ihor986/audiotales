import 'dart:async';
import 'package:flutter/material.dart';
import '../utils/consts/custom_colors.dart';
import '../widgets/texts/memory_box_text.dart';
import '../widgets/texts/start_regular_user_text.dart';
import '../widgets/uncategorized/custom_clipper_widget.dart';
import 'main_screen/main_screen.dart';

class RegularUserPage extends StatefulWidget {
  const RegularUserPage({Key? key}) : super(key: key);
  static const routeName = '/regular_user.dart';

  @override
  State<RegularUserPage> createState() => _RegularUserPageState();
}

class _RegularUserPageState extends State<RegularUserPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
        MainScreen.routeName,
        (_) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // bool secondPage = true;
    num screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: CustomColors.blueSoso,
        elevation: 0,
      ),
      body: Column(
        children: [
          ClipPath(
            clipper: OvalBC(),
            child: Container(
              height: screenHeight / 4.5,
              color: CustomColors.blueSoso,
              child: const MamoryBox(),
            ),
          ),
          const StartRegularUserText1(),
          const StartRegularUserText2()
        ],
      ),
    );
    // : Test();
  }
}
