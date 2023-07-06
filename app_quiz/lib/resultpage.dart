import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key, this.successes}) : super(key: key);

  final int? successes;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Quiz')),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Result:',
                  style: const TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'You got\n $successes out of 10\n question correct.',
                  style: const TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      print('clicked');
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20)),
                    child: const Text(
                      'Play Again',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
