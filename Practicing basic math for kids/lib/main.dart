import 'package:flutter/material.dart';
import 'dart:math';

class OperationScreen extends StatefulWidget {
  final String operation;
  const OperationScreen({super.key, required this.operation});

  @override
  State<OperationScreen> createState() => _OperationScreenState();
}

class _OperationScreenState extends State<OperationScreen> {
  late int num1;
  late int num2;
  String userAnswer = '';
  String feedback = '';
  int score = 0;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _generateQuestion();
  }

  void _generateQuestion() {
    final rand = Random();
    switch (widget.operation) {
      case 'Addition':
        num1 = rand.nextInt(20) + 1;
        num2 = rand.nextInt(20) + 1;
        break;
      case 'Subtraction':
        num1 = rand.nextInt(20) + 10;
        num2 = rand.nextInt(10) + 1;
        break;
      case 'Multiplication':
        num1 = rand.nextInt(10) + 1;
        num2 = rand.nextInt(10) + 1;
        break;
      case 'Division':
        num2 = rand.nextInt(9) + 2;
        int temp = rand.nextInt(10) + 1;
        num1 = num2 * temp;
        break;
      default:
        num1 = 0;
        num2 = 0;
    }
    userAnswer = '';
    feedback = '';
    _controller.clear();
    setState(() {});
  }

  int _correctAnswer() {
    switch (widget.operation) {
      case 'Addition':
        return num1 + num2;
      case 'Subtraction':
        return num1 - num2;
      case 'Multiplication':
        return num1 * num2;
      case 'Division':
        return (num1 ~/ num2);
      default:
        return 0;
    }
  }

  void _checkAnswer() {
    if (userAnswer.isEmpty) return;
    int? answer = int.tryParse(userAnswer);
    if (answer == null) {
      setState(() {
        feedback = 'Please enter a number!';
      });
      return;
    }
    if (answer == _correctAnswer()) {
      setState(() {
        feedback = '🎉 Great job!';
        score++;
      });
      Future.delayed(const Duration(seconds: 1), _generateQuestion);
    } else {
      setState(() {
        feedback = 'Try again!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String question = '';
    String op = '';
    switch (widget.operation) {
      case 'Addition':
        op = '+';
        break;
      case 'Subtraction':
        op = '-';
        break;
      case 'Multiplication':
        op = '×';
        break;
      case 'Division':
        op = '÷';
        break;
    }
    question = '$num1 $op $num2 = ?';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: Text(
          '${widget.operation} Practice',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade100, Colors.pink.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              question,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: 120,
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 28, color: Colors.deepPurple),
                textAlign: TextAlign.center,
                onChanged: (val) => setState(() => userAnswer = val),
                decoration: InputDecoration(
                  hintText: 'Answer',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkAnswer,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                textStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              child: Text('Check'),
            ),
            SizedBox(height: 20),
            Text(
              feedback,
              style: TextStyle(
                fontSize: 24,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Score: $score',
              style: TextStyle(
                fontSize: 22,
                color: Colors.purple,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back, color: Colors.white),
              label: Text(
                'Back to Menu',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math Fun for Kids',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Math Fun for Kids'),
      routes: {
        '/addition': (context) => const OperationScreen(operation: 'Addition'),
        '/subtraction': (context) =>
            const OperationScreen(operation: 'Subtraction'),
        '/multiplication': (context) =>
            const OperationScreen(operation: 'Multiplication'),
        '/division': (context) => const OperationScreen(operation: 'Division'),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: Text(
          'Math Fun for Kids',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
            color: Colors.white,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        elevation: 8,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade100, Colors.pink.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Choose an Operation!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 40),
              _buildMenuButton(
                context,
                'Addition',
                Colors.orange,
                Icons.add,
                '/addition',
              ),
              const SizedBox(height: 20),
              _buildMenuButton(
                context,
                'Subtraction',
                Colors.blue,
                Icons.remove,
                '/subtraction',
              ),
              const SizedBox(height: 20),
              _buildMenuButton(
                context,
                'Multiplication',
                Colors.green,
                Icons.clear,
                '/multiplication',
              ),
              const SizedBox(height: 20),
              _buildMenuButton(
                context,
                'Division',
                Colors.red,
                Icons.horizontal_split,
                '/division',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(
    BuildContext context,
    String label,
    Color color,
    IconData icon,
    String route,
  ) {
    return SizedBox(
      width: 250,
      height: 60,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 6,
        ),
        icon: Icon(icon, size: 32, color: Colors.white),
        label: Text(
          label,
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
      ),
    );
  }
}
