import 'package:flutter/material.dart';
import '../../../utils/consts/custom_colors.dart';
import '../../../widgets/texts/start_new_user_text.dart';
import '../../../widgets/uncategorized/custom_clipper_widget.dart';
import 'auth_buttons/continue_button.dart';

class NewUserPage extends StatelessWidget {
  const NewUserPage({Key? key}) : super(key: key);
  static const routeName = '/new_user/new_user.dart';

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
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
                  height: screen.height / 4.5,
                  color: CustomColors.blueSoso,
                  child: const _MamoryBox(),
                ),
              ),
              const StartNewUserText(),
              const ContinueButtonNewUser(),
            ],
          ),
        ],
      ),
    );
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
