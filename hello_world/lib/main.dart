import 'package:flutter/material.dart';

void main() {
  int value = 10;

  runApp(MyApp(title: 'My first app title', value: value,));
  value++; // Não consiguimos mudar pois estamos utilizando o StatelessWidget

}

class MyApp extends StatelessWidget {
  final String title;
  final int value;

  const MyApp({Key? key, this.title = '', this.value = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(this.title),
        ),
        body:  Center(
          child: Text(
            'First APP, value is $value',
            style: const TextStyle(fontSize: 30, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
