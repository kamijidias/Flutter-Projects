import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp(name: 'Andrew'));
}

class MyApp extends StatefulWidget {
  final String name;

  const MyApp({ Key? key, this.name = ''}) : super(key:key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  int salary = 7000;

  void increaseSalary(int value) {
    setState(() {
      salary = salary + value;
    });
  }

  void decreaseSalary(int value) {
    setState(() {
      salary = salary - value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          print('clicked');

          increaseSalary(500);

        },
        child: Text('The salary of ${widget.name} is $salary',
        textDirection: TextDirection.ltr,
        ),
      ),
    );
  }
}