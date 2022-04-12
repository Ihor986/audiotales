import 'package:flutter/material.dart';

class StartNewUserText extends StatelessWidget {
  const StartNewUserText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // num width = MediaQuery.of(context).size.width;
    num screenHeight = MediaQuery.of(context).size.height;
    return Column(children: [
      SizedBox(height: screenHeight / 18),
      Text(
        hello,
        style: const TextStyle(
          fontSize: 24,
        ),
      ),
      SizedBox(height: screenHeight / 30),
      Column(
        children: [
          Text(
            textHello1,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            textHello2,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            textHello3,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            textHello4,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
      SizedBox(height: screenHeight / 18),
    ]);
  }
}

String hello = 'Привет!';
String textHello1 = 'Мы рады видеть тебя здесь.';
// Мы рады видеть тебя здесь.
// Это приложение поможет записывать
// сказки и держать их в удобном месте не
// заполняя память на телефоне''';
String textHello2 = 'Это приложение поможет записывать';
String textHello3 = 'сказки и держать их в удобном месте не';
String textHello4 = 'заполняя память на телефоне';
