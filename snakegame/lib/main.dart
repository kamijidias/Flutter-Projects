// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:snakegame/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
    apiKey: 'AIzaSyCp4N399eMOhvzOFurs749WsmcOQEY8Ha4',
    appId: '1:835465547069:web:442a45727f6bb632210954',
    messagingSenderId: '835465547069',
    projectId: 'snakegame-ad5ed',
    authDomain: 'snakegame-ad5ed.firebaseapp.com',
    storageBucket: 'snakegame-ad5ed.appspot.com',
    measurementId: 'G-00C5514RS2',
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(brightness: Brightness.dark),
    );
  }
}
