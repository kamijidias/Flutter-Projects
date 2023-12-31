import 'package:app_quiz/resultpage.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    List quiz = [
      {
        "Question": "What is Flutter?",
        "Answer": [
          "A programming language",
          "A mobile operating system",
          "A UI toolkit",
          "A game development framework"
        ],
        "correct_answer": 2
      }
    ];

    quiz.add(
      {
        "Question": "Which company developed Flutter?",
        "Answer": ["Google", "Apple", "Microsoft", "Facebook"],
        "correct_answer": 0
      },
    );

    quiz.add({
      "Question": "Which programming language is used by Flutter?",
      "Answer": ["JavaScript", "Python", "Dart", "Java"],
      "correct_answer": 2
    });

    quiz.add({
      "Question": "What platforms can Flutter apps run on?",
      "Answer": ["iOS only", "Android only", "Web only", "iOS and Android"],
      "correct_answer": 3
    });

    quiz.add({
      "Question": "What is the primary goal of Flutter?",
      "Answer": [
        "Web development",
        "Game development",
        "Desktop application development",
        "Building beautiful native apps"
      ],
      "correct_answer": 3
    });

    quiz.add({
      "Question": "Which widget is used for building layouts in Flutter?",
      "Answer": ["Container", "Text", "Image", "Column"],
      "correct_answer": 3
    });

    quiz.add({
      "Question": "What is hot reload in Flutter?",
      "Answer": [
        "A feature for running Flutter apps on the web",
        "A process for testing apps on multiple devices simultaneously",
        "A technique for quickly seeing changes in the app during development",
        "A way to optimize app performance"
      ],
      "correct_answer": 2
    });

    quiz.add({
      "Question": "What is Flutter's declarative UI approach?",
      "Answer": [
        "Creating user interfaces with HTML",
        "Writing code in a procedural manner",
        "Defining the desired outcome rather than specifying step-by-step instructions",
        "Using XML for designing layouts"
      ],
      "correct_answer": 2
    });

    quiz.add({
      "Question": "What is the package manager used in Flutter?",
      "Answer": ["Gradle", "CocoaPods", "Pub", "npm"],
      "correct_answer": 2
    });

    quiz.add({
      "Question": "What is the entry point of a Flutter app?",
      "Answer": ["main.dart", "index.html", "app.js", "MainActivity.java"],
      "correct_answer": 0
    });

    int questionNumber = 1;
    int correctCount = 1;
    int wrongCount = 0;
    int totalQuestions = 10;

    void answered(int answerNumber) {
      setState(() {
        if (quiz[questionNumber - 1]["correct_answer"] == answerNumber) {
          print("success");
          correctCount++;
        } else {
          print("wrong choice");
          wrongCount++;
        }

        print(
            'Total correct answers: $correctCount, Total wrong answer: $wrongCount');

        if (questionNumber == totalQuestions) {
          Navigator.pushNamed(
            context,
            'ResultPage',
            arguments: Arguments(correctCount),
          );
          print('Quiz ended');
        } else {
          questionNumber++;
        }
      });
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Quiz')),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  'Question $questionNumber of 10',
                  style: const TextStyle(fontSize: 30),
                ),
              ),
              Text(
                'Question: ${quiz[questionNumber - 1]["Question"]}',
                style: const TextStyle(fontSize: 30),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    print('clicked');
                    answered(0);
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(100, 20, 100, 20)),
                  child: Text(
                    quiz[questionNumber - 1]["Answer"][0],
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    print('clicked');
                    answered(1);
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(100, 20, 100, 20)),
                  child: Text(
                    quiz[questionNumber - 1]["Answer"][1],
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    print('clicked');
                    answered(2);
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(100, 20, 100, 20)),
                  child: Text(
                    quiz[questionNumber - 1]["Answer"][2],
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    print('clicked');
                    answered(3);
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(100, 20, 100, 20)),
                  child: Text(
                    quiz[questionNumber - 1]["Answer"][3],
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
