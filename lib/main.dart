import 'package:flutter/material.dart';
import 'fade.dart';
import 'game_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'PressStart2P',
      ),
      home: const GameScreen(),
    );
  }
}
// AnimatedRotation(
//                     turns: turns,
//                     duration: const Duration(seconds: 1),
//                     child: Column(
//                       children: const [
//                         Text(
//                           'Type: Owl',
//                           style: TextStyle(fontSize: 18),
//                         ),
//                         Text(
//                           'Age: 39',
//                           style: TextStyle(fontSize: 18),
//                         ),
//                         Text(
//                           'Employment: None',
//                           style: TextStyle(fontSize: 18),
//                         ),
//                       ],
//                     ),
//                   ), 