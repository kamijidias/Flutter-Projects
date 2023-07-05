import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Text\nText 2',
        textDirection: TextDirection.ltr,
        style: TextStyle(
          fontSize: 50,
          height: 1.15,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w700,
          color: Colors.black,
          backgroundColor: Colors.yellow,
          decoration: TextDecoration.overline,
        ),
      ),
    );
  }
}
