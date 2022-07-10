import 'dart:async';
import 'package:flutter/material.dart';
import '../../utils/custom_colors.dart';
import '../../utils/texts_consts.dart';
import '../../widgets/uncategorized/custom_clipper_widget.dart';
import '../main_screen/main_screen.dart';

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
    Timer(
      const Duration(seconds: 2),
      () {
        Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
          MainScreen.routeName,
          (_) => false,
        );
      },
    );
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
              child: const _MamoryBox(),
            ),
          ),
          const _StartRegularUserText1(),
          const _StartRegularUserText2()
        ],
      ),
    );
    // : Test();
  }
}

class _MamoryBox extends StatelessWidget {
  const _MamoryBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(
          child: Text(
            'MemoryBox',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontStyle: FontStyle.normal,
              fontSize: 48,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            SizedBox(),
            Text(
              'твой голос всегда рядом',
              textAlign: TextAlign.end,
              style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.normal,
                fontSize: 14,
              ),
            ),
          ],
        )
      ],
    );
  }
}

class _StartRegularUserText1 extends StatelessWidget {
  const _StartRegularUserText1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    num screenWidth = MediaQuery.of(context).size.width;
    num screenHeight = MediaQuery.of(context).size.height;

    return Column(children: [
      SizedBox(
        height: screenHeight / 15,
      ),
      Container(
        child: const Center(
          child: Text(
            TextsConst.hello,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        height: screenHeight / 15,
        width: screenWidth * 0.7,
        decoration: BoxDecoration(
          color: CustomColors.white,
          boxShadow: const [
            BoxShadow(
              color: CustomColors.boxShadow,
              offset: Offset(0, 5),
              blurRadius: 6,
            ),
          ],
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      SizedBox(
        height: screenHeight / 14,
      ),
      const Icon(
        Icons.favorite,
        color: CustomColors.rose,
        size: 45,
      ),
      SizedBox(
        height: screenHeight / 14,
      ),
    ]);
  }
}

class _StartRegularUserText2 extends StatelessWidget {
  const _StartRegularUserText2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    num screenWidth = MediaQuery.of(context).size.width;
    num screenHeight = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            TextsConst.textHello11,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          Text(
            TextsConst.textHello12,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
      height: screenHeight / 13,
      width: screenWidth * 0.7,
      decoration: BoxDecoration(
        color: CustomColors.white,
        boxShadow: const [
          BoxShadow(
            color: CustomColors.boxShadow,
            offset: Offset(0, 5),
            blurRadius: 6,
          ),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
