import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:flutter/material.dart';

class AuthorSubjectsWidget extends StatelessWidget {
  final Map<String, dynamic> author;

  const AuthorSubjectsWidget({super.key, required this.author});

  @override
  Widget build(BuildContext context) {
    final subjects = author['top_subjects'] as List<dynamic>;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.topSubjects,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              subjects
                  .map(
                    (subject) => Chip(
                      label: Text(subject),
                      backgroundColor: Colors.blue[50],
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }
}
