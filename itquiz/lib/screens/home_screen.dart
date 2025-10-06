import 'package:flutter/material.dart';
import '../data/questions.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  IconData _iconForSubject(Subject s) {
    switch (s) {
      case Subject.networking:
        return Icons.wifi;
      case Subject.dbms:
        return Icons.storage;
      case Subject.os:
        return Icons.computer;
      case Subject.dsa:
        return Icons.timeline;
      case Subject.oops:
        return Icons.code;
    }
  }

  Color _colorForSubject(Subject s, ThemeData theme) {
    switch (s) {
      case Subject.networking:
        return Colors.blueAccent;
      case Subject.dbms:
        return Colors.deepPurple;
      case Subject.os:
        return Colors.teal;
      case Subject.dsa:
        return Colors.orange;
      case Subject.oops:
        return Colors.indigo;
    }
  }

  @override
  Widget build(BuildContext context) {
    final subjects = Subject.values;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('IT Quiz - Subjects')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [theme.colorScheme.primary.withOpacity(0.08), Colors.white],
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: subjects.length,
          itemBuilder: (context, index) {
            final s = subjects[index];
            final color = _colorForSubject(s, theme);
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => QuizScreen(subject: s)),
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color.withOpacity(0.12),
                      ),
                      child: Icon(_iconForSubject(s), color: color),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            s.name.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${(questionsBySubject[s] ?? []).length} questions',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey[400],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
