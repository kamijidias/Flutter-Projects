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
  String number = 'Number';

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
      case 'AC':
        setState(() {
          number = '0';
        });
        break;
      default:
        break;
    }
  }

  GestureDetector buildGestureDetector(
      String text, Function(String) calculate) {
    return GestureDetector(
      onTap: () {
        calculate(text);
      },
      child: Text(
        text,
        style: const TextStyle(fontSize: 48),
      ),
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
                buildGestureDetector('<', calculate),
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
