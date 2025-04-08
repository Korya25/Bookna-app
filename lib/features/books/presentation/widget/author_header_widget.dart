import 'package:bookna_app/core/data/network/api_constants.dart';
import 'package:bookna_app/core/presentation/widget/image_with_shimmer.dart';
import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:bookna_app/features/books/domain/entities/author.dart';
import 'package:flutter/material.dart';

class AuthorHeaderWidget extends StatelessWidget {
  final Author author;
  final String authorName;

  const AuthorHeaderWidget({
    super.key,
    required this.author,
    required this.authorName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageWithShimmer(
          imageUrl: ApiConstants.authorPlaceholder,
          width: 100,
          height: 150,
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                author.name ?? authorName, // Fallback to passed name
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              if (author.topWork != null)
                Text(
                  "${AppStrings.topWork}: ${author.topWork}",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              const SizedBox(height: 8),
              if (author.workCount != null)
                Text(
                  '${AppStrings.works}: ${author.workCount}',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              const SizedBox(height: 8),
              if (author.alternateNames != null &&
                  author.alternateNames!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '${AppStrings.alsoKnownAs}:',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    ...author.alternateNames!.map<Widget>(
                      (name) => Text(
                        '• $name',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
