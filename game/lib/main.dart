import 'package:flutter/material.dart';
import 'screens/game_screen.dart';

void main() {
  runApp(const KidsSpellingGame());
}

class KidsSpellingGame extends StatelessWidget {
  const KidsSpellingGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kids Spelling Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        fontFamily: 'ProductSans',
      ),
      home: const GameScreen(),
    );
  }
}
