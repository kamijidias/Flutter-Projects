import 'package:flutter/material.dart';
import 'homepage.dart';
import 'resultpage.dart';
import 'quizpage.dart';

void main() {
  runApp(const ResultPage());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/' : (context) => HomePage(),
        'QuizPage' : (context) => QuizPage(),
        ResultPage.route : (context) => ResultPage(),
      },
    );
  }
}