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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Application Examplo Scaffold'),
        ),
        body: const Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Text(
                'Column',
                style: TextStyle(fontSize: 32),
              ),
            ),
            Center(
              child: Text(
                'Column 1',
                style: TextStyle(fontSize: 32),
              ),
            ),
            Center(
              child: Text(
                'Column 2',
                style: TextStyle(fontSize: 32),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
