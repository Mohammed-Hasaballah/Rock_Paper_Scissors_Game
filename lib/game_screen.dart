import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  //
  late String userChoice;
  late String systemChoice;
  late String userChoicePath;
  late String systemChoicePath;
  late int clicks;
  late int score;
  int maxNumOfRounds = 10;
  late Map<String, Map<String, String>> gameResult;
  static List<String> choices = ["rock", "paper", "scisor"];
  late bool showResult;
  late bool winner;
  void resetGame() {
    setState(() {
      score = 0;
      clicks = 0;
      showResult = false;
      winner = false;
      userChoice = 'rock';
      systemChoice = 'rock';
      userChoicePath = 'images/rock_btn.png';
      systemChoicePath = 'images/rock_btn.png';
      gameResult = {
        "rock": {
          "rock": "It's a Draw",
          "paper": "You Lose",
          "scisor": "You Win",
        },
        "paper": {
          "rock": "You Win",
          "paper": "It's a Draw",
          "scisor": "You Lose",
        },
        "scisor": {
          "rock": "You Lose",
          "paper": "You Win",
          "scisor": "It's a Draw",
        }
      };
    });
  }

  @override
  void initState() {
    clicks = 0;
    score = 0;
    showResult = false;
    winner = false;
    userChoice = 'rock';
    systemChoice = 'rock';
    userChoicePath = 'images/rock_btn.png';
    systemChoicePath = 'images/rock_btn.png';
    gameResult = {
      "rock": {
        "rock": "It's a Draw",
        "paper": "You Lose",
        "scisor": "You Win",
      },
      "paper": {
        "rock": "You Win",
        "paper": "It's a Draw",
        "scisor": "You Lose",
      },
      "scisor": {
        "rock": "You Lose",
        "paper": "You Win",
        "scisor": "It's a Draw",
      }
    };

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 223, 221, 220),
      appBar: AppBar(
        title: const Text('Rock Paper Scissors Game '),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            setState(() {
                              clicks++;
                              if (clicks == maxNumOfRounds) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          if (score < 5)
                                            Image.asset(
                                              'images/fail.png',
                                              height: 80,
                                            )
                                          else
                                            Image.asset(
                                              'images/pass.png',
                                              height: 80,
                                            ),
                                          const SizedBox(height: 10),
                                          const Text(
                                            'End Of The Match ',
                                            style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            'Your Score Is $score / $maxNumOfRounds',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: winner
                                                    ? Colors.green
                                                    : Colors.red),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            resetGame();
                                          },
                                          child: const Text(
                                            'Play Again',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            SystemNavigator.pop();
                                          },
                                          child: const Text(
                                            'Exit',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }

                              int userRandomIndex = Random().nextInt(3);
                              userChoice = choices[userRandomIndex];
                              userChoicePath = 'images/${userChoice}_btn.png';

                              int systemRandomIndex = Random().nextInt(3);
                              systemChoice = choices[systemRandomIndex];
                              systemChoicePath =
                                  'images/${systemChoice}_btn.png';
                              if (gameResult[userChoice]![systemChoice]! ==
                                  'You Win') {
                                score++;
                              }
                              showResult = true;
                              if (score >= 5) {
                                winner = true;
                              }
                            });
                          },
                          child: Image.asset(userChoicePath)),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'You',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
                  const Text(
                    'VS',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        systemChoicePath,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'System',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ))
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              if (showResult)
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        gameResult[userChoice]![systemChoice]!,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Score: ${score.toString()}',
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
