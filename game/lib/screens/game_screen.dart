import 'dart:async';

import 'package:flutter/material.dart';

import '../data/questions.dart';
import '../models/question.dart';
import '../widgets/option_button.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  int index = 0;
  int score = 0;
  bool isLocked = false;
  String feedback = '';

  late Question current;

  @override
  void initState() {
    super.initState();
    current = sampleQuestions[index];
  }

  void selectOption(String option) {
    if (isLocked) return;
    setState(() {
      isLocked = true;
      if (option == current.correct) {
        score += 1;
        feedback = 'Correct!';
      } else {
        feedback = 'Try again';
      }
    });

    Timer(const Duration(milliseconds: 900), () {
      setState(() {
        // move to next
        isLocked = false;
        feedback = '';
        if (index < sampleQuestions.length - 1) {
          index += 1;
          current = sampleQuestions[index];
        } else {
          // show finished dialog
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => AlertDialog(
              title: const Text('Well done!'),
              content: Text('Your score: $score / ${sampleQuestions.length}'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    resetGame();
                  },
                  child: const Text('Play Again'),
                ),
              ],
            ),
          );
        }
      });
    });
  }

  void resetGame() {
    setState(() {
      index = 0;
      score = 0;
      current = sampleQuestions[0];
      isLocked = false;
      feedback = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final options = List<String>.from(current.options)..shuffle();

    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        title: const Text('Match Image to Spelling'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(label: Text('Score: $score')),
                  Text('Question ${index + 1} / ${sampleQuestions.length}'),
                ],
              ),
              const SizedBox(height: 18),
              Expanded(
                flex: 5,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Builder(
                              builder: (context) {
                                // Try asset first if available, otherwise network
                                if (current.assetPath != null) {
                                  return Image.asset(
                                    current.assetPath!,
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error, stackTrace) {
                                      // If asset fails, fall back to network image
                                      return Image.network(
                                        current.networkUrl,
                                        fit: BoxFit.contain,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                              if (loadingProgress == null)
                                                return child;
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            },
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Center(
                                                  child: Icon(
                                                    Icons.broken_image,
                                                    size: 64,
                                                  ),
                                                ),
                                      );
                                    },
                                  );
                                }

                                // No asset specified, use network
                                return Image.network(
                                  current.networkUrl,
                                  fit: BoxFit.contain,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Center(
                                        child: Icon(
                                          Icons.broken_image,
                                          size: 64,
                                        ),
                                      ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (feedback.isNotEmpty)
                          Text(
                            feedback,
                            style: TextStyle(
                              fontSize: 20,
                              color: feedback == 'Correct!'
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Expanded(
                flex: 5,
                child: ListView.builder(
                  itemCount: options.length,
                  itemBuilder: (context, i) {
                    final opt = options[i];
                    Color bg = Colors.white;
                    if (isLocked &&
                        opt == current.correct &&
                        feedback == 'Correct!')
                      bg = Colors.green.shade300;
                    if (isLocked &&
                        opt != current.correct &&
                        feedback == 'Try again' &&
                        opt == opt) {
                      // keep default; we don't reveal wrong answer color here
                    }
                    return OptionButton(
                      text: opt,
                      color: bg,
                      onTap: () => selectOption(opt),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
