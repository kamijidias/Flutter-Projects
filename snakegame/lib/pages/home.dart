// ignore_for_file: prefer_const_constructors

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

class _HomePageState extends State<HomePage> {
  // grid dimensions
  int rowSize = 10;
  int totalNumberOfSquares = 100;

  // snake position
  List<int> snakePosition = [0, 1, 2];

  // food position
  int foodPosition = 55;

  // start game
  void startGame(){
    Timer.periodic(Duration(milliseconds: 200), (timer) {
      setState(() {
        // add a new header
        snakePosition.add(snakePosition.last + 1);
        // remove the tail
        snakePosition.removeAt(0);
      });
     });
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
                if (details.delta.dy > 0){
                  print('move down');
                }
                if (details.delta.dy < 0){
                  print('move up');
                }
              },
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 0){
                  print('move right');
                }
                if (details.delta.dx < 0){
                  print('move left');
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
