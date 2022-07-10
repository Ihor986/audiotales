import 'package:flutter/material.dart';
import '../../../utils/custom_colors.dart';
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
              const _StartNewUserText(),
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

class _StartNewUserText extends StatelessWidget {
  const _StartNewUserText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    num screenHeight = MediaQuery.of(context).size.height;
    return Column(children: [
      SizedBox(height: screenHeight / 18),
      const Text(
        hello,
        style: TextStyle(
          fontSize: 24,
        ),
      ),
      SizedBox(height: screenHeight / 30),
      Column(
        children: const [
          Text(
            textHello1,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            textHello2,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            textHello3,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            textHello4,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
      SizedBox(height: screenHeight / 18),
    ]);
  }

  static const String hello = 'Привет!';
  static const String textHello1 = 'Мы рады видеть тебя здесь.';
  static const String textHello2 = 'Это приложение поможет записывать';
  static const String textHello3 = 'сказки и держать их в удобном месте не';
  static const String textHello4 = 'заполняя память на телефоне';
}
