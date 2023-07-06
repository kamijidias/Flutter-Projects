import 'package:flutter/material.dart';

class Arguments {
  final int successes;

  Arguments(this.successes);
}

class ResultPage extends StatelessWidget {
  static const route = 'ResultPage';

  const ResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Arguments;

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
                const Text(
                  'Result:',
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'You got\n ${arguments.successes} out of 10\n question correct.',
                  style: const TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      print('clicked');
                      Navigator.pushNamed(context, 'QuizPage');
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
