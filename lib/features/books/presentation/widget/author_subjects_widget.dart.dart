import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:bookna_app/features/books/domain/entities/author.dart';
import 'package:flutter/material.dart';

class AuthorSubjectsWidget extends StatelessWidget {
  final Author author;

  const AuthorSubjectsWidget({super.key, required this.author});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.topSubjects,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        if (author.topSubjects != null && author.topSubjects!.isNotEmpty)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                author.topSubjects!
                    .map(
                      (subject) => Chip(
                        label: Text(subject),
                        backgroundColor: Colors.blue[50],
                      ),
                    )
                    .toList(),
          )
        else
          const Text('No subjects available'),
      ],
    );
  }
}
