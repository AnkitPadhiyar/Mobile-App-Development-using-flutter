import 'package:flutter/material.dart';
import '../data/questions.dart';
import '../models/question.dart';
import 'result_screen.dart';
import '../widgets/option_tile.dart';

class QuizScreen extends StatefulWidget {
  final Subject subject;

  const QuizScreen({super.key, required this.subject});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late final List<Question> _questions;
  int _index = 0;
  int _score = 0;
  int? _selected;
  bool _answered =
      false; // whether current question has been answered (feedback shown)

  @override
  void initState() {
    super.initState();
    _questions = questionsBySubject[widget.subject] ?? [];
  }

  void _submitAnswer() {
    if (!_answered) {
      // if not yet answered, treat this as "submit" and show feedback
      if (_selected == null) return; // require a selection
      setState(() {
        if (_selected == _questions[_index].answerIndex) _score++;
        _answered = true;
      });
      return;
    }

    // if already answered, move to next
    setState(() {
      _selected = null;
      _answered = false;
      _index++;
    });

    if (_index >= _questions.length) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            score: _score,
            total: _questions.length,
            subject: widget.subject,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.subject.name)),
        body: const Center(child: Text('No questions')),
      );
    }

    final q = _questions[_index];
    final progress = (_index + 1) / _questions.length;
    return Scaffold(
      appBar: AppBar(title: Text(widget.subject.name.toUpperCase())),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LinearProgressIndicator(
              value: progress,
              color: theme.colorScheme.primary,
              backgroundColor: theme.colorScheme.primary.withOpacity(0.2),
            ),
            const SizedBox(height: 12),
            Text(
              'Question ${_index + 1} of ${_questions.length}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  q.question,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            ...List.generate(q.options.length, (i) {
              final correctIndex = _questions[_index].answerIndex;
              return OptionTile(
                text: q.options[i],
                selected: _selected == i && !_answered,
                isCorrect: _answered && i == correctIndex,
                isIncorrect: _answered && _selected == i && i != correctIndex,
                onTap: _answered
                    ? () {}
                    : () => setState(() {
                        _selected = i;
                      }),
              );
            }),
            const SizedBox(height: 12),
            if (_answered)
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: (_selected == _questions[_index].answerIndex)
                      ? Colors.green.shade50
                      : Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      _selected == _questions[_index].answerIndex
                          ? Icons.check_circle
                          : Icons.cancel,
                      color: _selected == _questions[_index].answerIndex
                          ? Colors.green.shade700
                          : Colors.red.shade700,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _selected == _questions[_index].answerIndex
                            ? 'Correct! Well done.'
                            : 'Incorrect. The correct answer is: ${q.options[_questions[_index].answerIndex]}',
                        style: TextStyle(
                          color: _selected == _questions[_index].answerIndex
                              ? Colors.green.shade800
                              : Colors.red.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            const Spacer(),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _submitAnswer,
                child: Text(
                  !_answered
                      ? 'Submit'
                      : (_index + 1 < _questions.length ? 'Next' : 'Finish'),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
