import 'package:flutter/material.dart';
import '../screens/form.dart';
import '../widgets/template_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.article, size: 22),
            const SizedBox(width: 8),
            const Text('Resume Maker'),
            const Spacer(),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.info_outline, size: 18),
              label: const Text('About'),
            ),
          ],
        ),
        surfaceTintColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),
            Text(
              'Choose a template',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxis = constraints.maxWidth > 700 ? 3 : 2;
                  return GridView.count(
                    crossAxisCount: crossAxis,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: List.generate(
                      6,
                      (index) => TemplateCard(
                        title: index == 0
                            ? 'Professional'
                            : 'Template ${index + 1}',
                        subtitle: index == 0
                            ? 'Clean & modern'
                            : (index % 2 == 0 ? 'Classic' : 'Modern'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ResumeFormScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ResumeFormScreen()),
        ),
        label: const Text('Create'),
        icon: const Icon(Icons.create),
      ),
    );
  }
}
