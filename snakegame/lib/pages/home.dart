// ignore_for_file: prefer_const_constructors, constant_identifier_names

import 'dart:async';

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

  // snake position
  List<int> snakePosition = [0, 1, 2];

  // snake direction is initially to the right
  var currentDirection = snake_Direction.RIGHT;

  // food position
  int foodPosition = 55;

  // start game
  void startGame() {
    Timer.periodic(Duration(milliseconds: 200), (timer) {
      setState(() {
        moveSnake();
      });
    });
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
          // remove tail
          snakePosition.removeAt(0);
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
          // remove tail
          snakePosition.removeAt(0);
        }
        break;
      case snake_Direction.UP:
        {
          // add a head
          // if snake is at the top wall, need to re-adjust
          if (snakePosition.last < rowSize) {
            snakePosition.add(snakePosition.last - rowSize + totalNumberOfSquares);
          } else {
            snakePosition.add(snakePosition.last - rowSize );
          }
          // remove tail
          snakePosition.removeAt(0);
        }
        break;
      case snake_Direction.DOWN:
        {
          // add a head
          // if snake is at the bottom wall, need to re-adjust
          if (snakePosition.last + rowSize > totalNumberOfSquares) {
            snakePosition.add(snakePosition.last + rowSize - totalNumberOfSquares);
          } else {
            snakePosition.add(snakePosition.last + rowSize );
          }
          // remove tail
          snakePosition.removeAt(0);
        }
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // high scores
          Expanded(
            child: Container(),
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
                  onPressed: startGame,
                  child: Text('Play'),
                  color: Colors.pink,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
