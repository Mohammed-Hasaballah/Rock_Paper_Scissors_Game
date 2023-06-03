import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rock_paper_scissors/start_screen.dart';
import 'package:audioplayers/audioplayers.dart';

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
  late bool winner;
  bool isPlay = false;
  double turns = 1;
  void resetGame() {
    setState(() {
      score = 0;
      clicks = 0;
      winner = false;
      userChoice = 'rock';
      systemChoice = 'rock';
      userChoicePath = 'images/rock_btn.png';
      systemChoicePath = 'images/rock_btn.png';
      gameResult = {
        "rock": {
          "rock": "Draw",
          "paper": "You Lose",
          "scisor": "You Win",
        },
        "paper": {
          "rock": "You Win",
          "paper": "Draw",
          "scisor": "You Lose",
        },
        "scisor": {
          "rock": "You Lose",
          "paper": "You Win",
          "scisor": "Draw",
        }
      };
    });
  }

  void playMusic(String x) {
    final player = AudioPlayer();
    player.play(AssetSource('$x.mp3'));
  }

  @override
  void initState() {
    clicks = 0;
    score = 0;
    winner = false;
    userChoice = 'rock';
    systemChoice = 'rock';
    userChoicePath = 'images/rock_btn.png';
    systemChoicePath = 'images/rock_btn.png';
    gameResult = {
      "rock": {
        "rock": "Draw",
        "paper": "You Lose",
        "scisor": "You Win",
      },
      "paper": {
        "rock": "You Win",
        "paper": "Draw",
        "scisor": "You Lose",
      },
      "scisor": {
        "rock": "You Lose",
        "paper": "You Win",
        "scisor": "Draw",
      }
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        gameResult[userChoice]![systemChoice]!,
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Score: ${score.toString()}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: isPlay,
                  maintainState: true,
                  maintainAnimation: true,
                  maintainSize: true,
                  child: AnimatedOpacity(
                    opacity: isPlay ? 1 : 0,
                    duration: const Duration(milliseconds: 350),
                    child: AnimatedRotation(
                      duration: const Duration(milliseconds: 350),
                      turns: turns,
                      child: Column(
                        children: [
                          Image.asset(
                            'images/paper_btn.png',
                            height: 35,
                            width: 35,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'images/rock_btn.png',
                                height: 35,
                                width: 35,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Image.asset(
                                'images/scisor_btn.png',
                                height: 35,
                                width: 35,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedScale(
                            scale: isPlay ? 0.0 : 1.0,
                            duration: const Duration(milliseconds: 500),
                            child: Image.asset(userChoicePath),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'You',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                color: Colors.white),
                          ),
                        ],
                      )),
                      const Text(
                        'VS',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedScale(
                            scale: isPlay ? 0.0 : 1.0,
                            duration: const Duration(milliseconds: 500),
                            child: Image.asset(
                              systemChoicePath,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'System',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
                Column(
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        setState(() {
                          isPlay = true;
                          turns++;
                          playMusic('loop');
                        });

                        Timer(const Duration(milliseconds: 500), () {
                          setState(() {
                            playMusic('pop_up');
                            userChoice = 'paper';
                            userChoicePath = 'images/paper_btn.png';
                            clicks++;
                            isPlay = false;
                            if (clicks == maxNumOfRounds) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return WillPopScope(
                                    onWillPop: () async {
                                      resetGame();
                                      return true;
                                    },
                                    child: AlertDialog(
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
                                          const SizedBox(height: 15),
                                          const Text(
                                            'End Of The Match ',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          const SizedBox(height: 25),
                                          Text(
                                            'Your Score Is $score / $maxNumOfRounds',
                                            style: TextStyle(
                                                fontSize: 12,
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
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 11),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const StartScreen()));
                                          },
                                          child: const Text(
                                            'Back to Home',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 11,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }

                            int systemRandomIndex = Random().nextInt(3);
                            systemChoice = choices[systemRandomIndex];
                            systemChoicePath = 'images/${systemChoice}_btn.png';
                            if (gameResult[userChoice]![systemChoice]! ==
                                'You Win') {
                              score++;
                            }
                            if (score >= 5) {
                              winner = true;
                            }
                          });
                        });
                      },
                      child: Image.asset(
                        'images/paper_btn.png',
                        height: 80,
                        width: 80,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            setState(() {
                              isPlay = true;
                              turns++;
                              playMusic('loop');
                            });
                            Timer(const Duration(milliseconds: 500), () {
                              setState(() {
                                playMusic('pop_up');
                                userChoice = 'rock';
                                userChoicePath = 'images/rock_btn.png';
                                clicks++;
                                isPlay = false;
                                if (clicks == maxNumOfRounds) {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return WillPopScope(
                                        onWillPop: () async {
                                          resetGame();
                                          return true;
                                        },
                                        child: AlertDialog(
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
                                              const SizedBox(height: 15),
                                              const Text(
                                                'End Of The Match ',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                              const SizedBox(height: 25),
                                              Text(
                                                'Your Score Is $score / $maxNumOfRounds',
                                                style: TextStyle(
                                                    fontSize: 12,
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
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const StartScreen()));
                                              },
                                              child: const Text(
                                                'Back to Home',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }
                                int systemRandomIndex = Random().nextInt(3);
                                systemChoice = choices[systemRandomIndex];
                                systemChoicePath =
                                    'images/${systemChoice}_btn.png';
                                if (gameResult[userChoice]![systemChoice]! ==
                                    'You Win') {
                                  score++;
                                }
                                if (score >= 5) {
                                  winner = true;
                                }
                              });
                            });
                          },
                          child: Image.asset(
                            'images/rock_btn.png',
                            height: 80,
                            width: 80,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            setState(() {
                              isPlay = true;
                              turns++;
                              playMusic('loop');
                            });
                            Timer(const Duration(milliseconds: 500), () {
                              setState(() {
                                playMusic('pop_up');
                                userChoice = 'scisor';
                                userChoicePath = 'images/scisor_btn.png';
                                clicks++;
                                isPlay = false;
                                if (clicks == maxNumOfRounds) {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return WillPopScope(
                                        onWillPop: () async {
                                          resetGame();
                                          return true;
                                        },
                                        child: AlertDialog(
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
                                              const SizedBox(height: 15),
                                              const Text(
                                                'End Of The Match ',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                              const SizedBox(height: 25),
                                              Text(
                                                'Your Score Is $score / $maxNumOfRounds',
                                                style: TextStyle(
                                                    fontSize: 12,
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
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const StartScreen()));
                                              },
                                              child: const Text(
                                                'Back to Home',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }
                                int systemRandomIndex = Random().nextInt(3);
                                systemChoice = choices[systemRandomIndex];
                                systemChoicePath =
                                    'images/${systemChoice}_btn.png';
                                if (gameResult[userChoice]![systemChoice]! ==
                                    'You Win') {
                                  score++;
                                }
                                if (score >= 5) {
                                  winner = true;
                                }
                              });
                            });
                          },
                          child: Image.asset(
                            'images/scisor_btn.png',
                            height: 80,
                            width: 80,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
