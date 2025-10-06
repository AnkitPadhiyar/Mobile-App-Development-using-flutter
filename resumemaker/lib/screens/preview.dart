import 'package:flutter/material.dart';
import '../models/resume.dart';

class PreviewScreen extends StatelessWidget {
  final Resume resume;
  const PreviewScreen({super.key, required this.resume});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume Preview'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.print)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Card(
              elevation: 6,
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // left accent column
                  Container(
                    width: 120,
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.06),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          child: Text(
                            resume.name.isNotEmpty ? resume.name[0] : '?',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        if (resume.email.isNotEmpty)
                          Text(
                            resume.email,
                            style: const TextStyle(fontSize: 12),
                          ),
                        if (resume.phone.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            resume.phone,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ],
                    ),
                  ),
                  // main content
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            resume.name,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          if (resume.title.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 6.0),
                              child: Text(
                                resume.title,
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(color: Colors.grey[700]),
                              ),
                            ),
                          const SizedBox(height: 12),
                          if (resume.summary.isNotEmpty) ...[
                            const Text(
                              'Summary',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(resume.summary),
                          ],
                          // TODO: sections like Experience, Education, Skills can be added here
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
