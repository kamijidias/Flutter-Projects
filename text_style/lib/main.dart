import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        backgroundColor: Colors.purple,
        appBar: AppBar(
          title: const Text('Application examplo scaffold'),
          backgroundColor: Colors.purple,
        ),
        body: const Center(
          child: Text(
            'Text\nText 2',
            textDirection: TextDirection.ltr,
            style: TextStyle(
              fontSize: 50,
            ),
          ),
        ),
      ),
    );
  }
}   
    
  //   Center(
  //     child: Text(
  //       'Text\nText 2',
  //       textDirection: TextDirection.ltr,
  //       style: TextStyle(
  //         fontSize: 50,
  //         height: 1.15,
  //         fontStyle: FontStyle.italic,
  //         fontWeight: FontWeight.w700,
  //         color: Colors.black,
  //         backgroundColor: Colors.yellow,
  //         decoration: TextDecoration.overline,
  //         fontFamily: 'Chopin',
  //       ),
  //     ),
  //   );
  // }
