import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String calculator = 'Calculator';
  String number = '0';
  double firstNumber = 0.0;
  String operation = '';

  void calculate(String keyboard) {
    switch (keyboard) {
      case '0':
      case '1':
      case '2':
      case '3':
      case '4':
      case '5':
      case '6':
      case '7':
      case '8':
      case '9':
      case ',':
        setState(() {
          number += keyboard;

          number = number.replaceAll(',', '.');

          if (number.contains('.')) {
            // double? numberDouble = double.parse(number);
            // number = numberDouble.toString();
          } else {
            int? numberInt = int.parse(number);
            number = numberInt.toString();
          }
          number = number.replaceAll('.', ',');
        });
        break;

      case '+':
      case '-':
      case 'X':
      case '/':
        operation = keyboard;
        number = number.replaceAll(',', '.');
        firstNumber = double.parse(number);
        number = '0';
        break;

      case '=':
        double result = 0.0;

        if (operation == '/') {
          if (double.parse(number) * 1 == 0) {
            return;
          }
        }

        if (operation == '+') {
          result = firstNumber + double.parse(number.replaceAll(',', '.'));
        }

        if (operation == '-') {
          result = firstNumber - double.parse(number.replaceAll(',', '.'));
        }

        if (operation == 'X') {
          result = firstNumber * double.parse(number.replaceAll(',', '.'));
        }

        if (operation == '/') {
          result = firstNumber / double.parse(number.replaceAll(',', '.'));
        }

        String resultString = result.toString();

        List<String> resultParts = resultString.split('.');

        if (int.parse(resultParts[1]) * 1 == 0) {
          setState(() {
            number = int.parse(resultParts[0]).toString();
          });
        } else {
          setState(() {
            number = result.toString();
          });
        }

        break;

      case 'AC':
        setState(() {
          number = '0';
        });
        break;

      case '<':
        setState(() {
          if (number.isNotEmpty) {
            number = number.substring(0, number.length - 1);
          }
        });
        break;

      default:
        break;
    }
  }

  GestureDetector buildGestureDetector(
      String text, Function(String) calculate, [String? imagePath]) {
    Widget childWidget;
    if (imagePath != null) {
      childWidget = Image.asset(
        imagePath,
        width: 60,
      );
    } else {
      childWidget = Text(
        text,
        style: const TextStyle(fontSize: 48),
      );
    }

    return GestureDetector(
      onTap: () {
        calculate(text);
      },
      child: childWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(calculator),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  number,
                  style: const TextStyle(fontSize: 72),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildGestureDetector('AC', calculate),
                const Text(''),
                const Text(''),
                buildGestureDetector('<', calculate, 'assets/images/arrow_back.png'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildGestureDetector('7', calculate),
                buildGestureDetector('8', calculate),
                buildGestureDetector('9', calculate),
                buildGestureDetector('/', calculate),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildGestureDetector('4', calculate),
                buildGestureDetector('5', calculate),
                buildGestureDetector('6', calculate),
                buildGestureDetector('X', calculate),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildGestureDetector('1', calculate),
                buildGestureDetector('2', calculate),
                buildGestureDetector('3', calculate),
                buildGestureDetector('-', calculate),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildGestureDetector('0', calculate),
                buildGestureDetector(',', calculate),
                buildGestureDetector('=', calculate),
                buildGestureDetector('+', calculate),
              ],
            ),
            const Text('created by Andrew Kamiji'),
          ],
        ),
      ),
    );
  }
}
