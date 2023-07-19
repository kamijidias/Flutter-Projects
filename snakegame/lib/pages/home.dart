// ignore_for_file: prefer_const_constructors, constant_identifier_names, camel_case_types

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snakegame/utils/blank_pixel.dart';
import 'package:snakegame/utils/food_pixel.dart';
import 'package:snakegame/utils/snake_pixel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum snake_Direction { UP, DOWN, LEFT, RIGHT }

class _HomePageState extends State<HomePage> {
  // grid dimensions
  int rowSize = 10;
  int totalNumberOfSquares = 100;

  bool gameHasStarted = false;

  // user score
  int currentScore = 0;

  // snake position
  List<int> snakePosition = [0, 1, 2];

  // snake direction is initially to the right
  var currentDirection = snake_Direction.RIGHT;

  // food position
  int foodPosition = 55;

  // start game
  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 200), (timer) {
      setState(() {
        // keep the snake moving!
        moveSnake();

        // check if the game is over
        if (gameOver()) {
          timer.cancel();

          //display a message to the user
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text('Game Over'),
                content: Column(
                  children: [
                    Text(
                      'Your score is: $currentScore',
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: 'Enter name'),
                    )
                  ],
                ),
                actions: [
                  MaterialButton(
                    onPressed: () {
                      submitScore();
                      Navigator.pop(context);
                      newGame();
                    },
                    color: Colors.pink,
                    child: Text('Submit'),
                  ),
                ],
              );
            },
          );
        }
      });
    });
  }

  void submitScore() {
    //
  }

  void newGame() {
    setState(() {
      snakePosition = [0, 1, 2];
      foodPosition = 55;
      currentDirection = snake_Direction.RIGHT;
      gameHasStarted = false;
      currentScore = 0;
    });
  }

  void eatFood() {
    currentScore++;
    // makin sure the new food is not where the snake is
    while (snakePosition.contains(foodPosition)) {
      foodPosition = Random().nextInt(totalNumberOfSquares);
    }
  }

  void moveSnake() {
    switch (currentDirection) {
      case snake_Direction.RIGHT:
        {
          // add a head
          // if snake is at the right wall, need to re-adjust
          if (snakePosition.last % rowSize == 9) {
            snakePosition.add(snakePosition.last + 1 - rowSize);
          } else {
            snakePosition.add(snakePosition.last + 1);
          }
        }
        break;
      case snake_Direction.LEFT:
        {
          // add a head
          // if snake is at the left wall, need to re-adjust
          if (snakePosition.last % rowSize == 0) {
            snakePosition.add(snakePosition.last - 1 + rowSize);
          } else {
            snakePosition.add(snakePosition.last - 1);
          }
        }
        break;
      case snake_Direction.UP:
        {
          // add a head
          // if snake is at the top wall, need to re-adjust
          if (snakePosition.last < rowSize) {
            snakePosition
                .add(snakePosition.last - rowSize + totalNumberOfSquares);
          } else {
            snakePosition.add(snakePosition.last - rowSize);
          }
        }
        break;
      case snake_Direction.DOWN:
        {
          // add a head
          // if snake is at the bottom wall, need to re-adjust
          if (snakePosition.last + rowSize > totalNumberOfSquares) {
            snakePosition
                .add(snakePosition.last + rowSize - totalNumberOfSquares);
          } else {
            snakePosition.add(snakePosition.last + rowSize);
          }
        }
        break;
      default:
    }

    // snake is eating food
    if (snakePosition.last == foodPosition) {
      eatFood();
    } else {
      // remove tail
      snakePosition.removeAt(0);
    }
  }

  // game over
  bool gameOver() {
    // the game is over when the snake runs into itself
    // this occours when there is a duplicate position in the snakePosition list

    // this list is the body of the snake (no head)
    List<int> bodySnake = snakePosition.sublist(0, snakePosition.length - 1);

    if (bodySnake.contains(snakePosition.last)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // high scores
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // user current score
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Current Score'),
                    Text(
                      currentScore.toString(),
                      style: TextStyle(fontSize: 40),
                    ),
                  ],
                ),

                // highscores, top 5
                Text('highscores...'),
              ],
            ),
          ),

          // game grid
          Expanded(
            flex: 3,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.delta.dy > 0 &&
                    currentDirection != snake_Direction.UP) {
                  currentDirection = snake_Direction.DOWN;
                }
                if (details.delta.dy < 0 &&
                    currentDirection != snake_Direction.DOWN) {
                  currentDirection = snake_Direction.UP;
                }
              },
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 0 &&
                    currentDirection != snake_Direction.LEFT) {
                  currentDirection = snake_Direction.RIGHT;
                }
                if (details.delta.dx < 0 &&
                    currentDirection != snake_Direction.RIGHT) {
                  currentDirection = snake_Direction.LEFT;
                }
              },
              child: GridView.builder(
                itemCount: totalNumberOfSquares,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: rowSize),
                itemBuilder: (context, index) {
                  if (snakePosition.contains(index)) {
                    return const SnakePixel();
                  } else if (foodPosition == index) {
                    return const FoodPixel();
                  } else {
                    return const BlackPixel();
                  }
                },
              ),
            ),
          ),

          // play button
          Expanded(
            child: Container(
              child: Center(
                child: MaterialButton(
                  onPressed: gameHasStarted ? () {} : startGame,
                  color: gameHasStarted ? Colors.grey : Colors.pink,
                  child: Text('Play'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}