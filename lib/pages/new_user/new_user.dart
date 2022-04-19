import 'package:flutter/material.dart';
import '../../utils/consts/custom_colors.dart';
import '../../widgets/buttons/continue_buttons/continue_button.dart';
import '../../widgets/texts/memory_box_text.dart';
import '../../widgets/texts/start_new_user_text.dart';
import '../../widgets/uncategorized/custom_clipper_widget.dart';

class NewUserPage extends StatelessWidget {
  const NewUserPage({Key? key}) : super(key: key);
  static const routeName = '/new_user/new_user.dart';

  @override
  Widget build(BuildContext context) {
    // num screenWidth = MediaQuery.of(context).size.width;
    num screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: CustomColors.blueSoso,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              ClipPath(
                clipper: OvalBC(),
                child: Container(
                  height: screenHeight / 4.5,
                  color: CustomColors.blueSoso,
                  child: const MamoryBox(),
                ),
              ),
              const StartNewUserText(),
              const ContinueButtonNewUser(),
            ],
          ),
          // const ContinueButtonNewUser(),
        ],
      ),
      // body: Column(
      //   children: [
      //     ClipPath(
      //       clipper: OvalBC(),
      //       child: Container(
      //         height: screenHeight / 3.7,
      //         color: blueSoso,
      //         child: const MamoryBox(),
      //       ),
      //     ),
      //     const StartNewUserText(),
      //     const ContinueButton(),
      //   ],
      // ),
      // ),
    );
  }
}
