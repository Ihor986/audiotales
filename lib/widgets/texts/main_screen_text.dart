// import 'package:audiotales/utils/consts/colors.dart';
import 'package:flutter/material.dart';

class SelectionText1 extends StatelessWidget {
  const SelectionText1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // num screenHeight = MediaQuery.of(context).size.height;
    return selections();
  }
}

class SelectionText2 extends StatelessWidget {
  const SelectionText2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // num screenHeight = MediaQuery.of(context).size.height;
    return openAll();
  }
}

class SelectionText3 extends StatelessWidget {
  const SelectionText3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // num screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: talesGroup(),
    );
  }
}

class SelectionText4 extends StatelessWidget {
  const SelectionText4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // num screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: talesGroup1(),
    );
  }
}

class SelectionText5 extends StatelessWidget {
  const SelectionText5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // num screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: talesGroup2(),
    );
  }
}

class SelectionText6 extends StatelessWidget {
  const SelectionText6({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // num screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: talesGroup3(),
    );
  }
}

class SelectionText7 extends StatelessWidget {
  const SelectionText7({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // num screenHeight = MediaQuery.of(context).size.height;
    return selectionsAudio();
  }
}

class SelectionText8 extends StatelessWidget {
  const SelectionText8({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // num screenHeight = MediaQuery.of(context).size.height;
    return openAllAudio();
  }
}

class SelectionText9 extends StatelessWidget {
  const SelectionText9({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return noTales(screenHeight);
  }
}

Text selections() => const Text(
      'Подборки',
      style: TextStyle(
        color: Colors.white,
        fontStyle: FontStyle.normal,
        fontSize: 20,
      ),
    );
Text openAll() => const Text(
      'Открыть все',
      style: TextStyle(
        color: Colors.white,
        fontStyle: FontStyle.normal,
        fontSize: 10,
      ),
    );
Widget talesGroup() => Column(
      children: const [
        Text(
          'Здесь будет',
          style: TextStyle(
            color: Colors.white,
            fontStyle: FontStyle.normal,
            fontSize: 17,
          ),
        ),
        Text(
          'твой набор',
          style: TextStyle(
            color: Colors.white,
            fontStyle: FontStyle.normal,
            fontSize: 17,
          ),
        ),
        Text(
          'сказок',
          style: TextStyle(
            color: Colors.white,
            fontStyle: FontStyle.normal,
            fontSize: 17,
          ),
        ),
      ],
    );
Widget talesGroup1() => const Center(
      child: Text(
        'Tут',
        style: TextStyle(
          color: Colors.white,
          fontStyle: FontStyle.normal,
          fontSize: 17,
        ),
      ),
    );
Widget talesGroup2() => const Center(
      child: Text(
        'И тут',
        style: TextStyle(
          color: Colors.white,
          fontStyle: FontStyle.normal,
          fontSize: 17,
        ),
      ),
    );
Widget talesGroup3() => Center(
      child: Stack(
        children: const [
          Text(
            'Добавить',
            style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.normal,
              fontSize: 12,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              '________',
              style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.normal,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
Text selectionsAudio() => const Text(
      'Аудиозаписи',
      style: TextStyle(
        color: Color.fromRGBO(58, 58, 85, 1),
        fontStyle: FontStyle.normal,
        fontSize: 20,
      ),
    );
Text openAllAudio() => const Text(
      'Открыть все',
      style: TextStyle(
        color: Color.fromRGBO(58, 58, 85, 1),
        fontStyle: FontStyle.normal,
        fontSize: 10,
      ),
    );
Widget noTales(screenHeight) => Center(
      child: Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.1),
        child: Column(
          children: [
            const Text(
              'Как только ты запишешь ',
              style: TextStyle(
                color: Color.fromRGBO(58, 58, 85, 0.5),
                fontStyle: FontStyle.normal,
                fontSize: 17,
              ),
            ),
            const Text(
              'аудио, она появится здесь.',
              style: TextStyle(
                color: Color.fromRGBO(58, 58, 85, 0.5),
                fontStyle: FontStyle.normal,
                fontSize: 17,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.1,
            ),
            const ImageIcon(
              AssetImage("assets/icons/arrow_down.png"),
              size: 37,
              color: Color.fromRGBO(58, 58, 85, 0.5),
            ),
          ],
        ),
      ),
    );
