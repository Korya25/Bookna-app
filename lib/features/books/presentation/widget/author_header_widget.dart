import 'package:bookna_app/core/data/network/api_constants.dart';
import 'package:bookna_app/core/presentation/widget/image_with_shimmer.dart';
import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:flutter/material.dart';

class AuthorHeaderWidget extends StatelessWidget {
  final Map<String, dynamic> author;
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
                authorName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "${AppStrings.topWork}: ${author['top_work']}",
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              const SizedBox(height: 8),
              Text(
                '${AppStrings.works}: ${author['work_count']}',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              const SizedBox(height: 8),
              if (author['alternate_names'] != null &&
                  author['alternate_names'].isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '${AppStrings.alsoKnownAs}:',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    ...author['alternate_names'].map<Widget>(
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
