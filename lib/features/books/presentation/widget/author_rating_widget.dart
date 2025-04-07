import 'package:bookna_app/core/resources/app_colors.dart';
import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:bookna_app/features/books/presentation/widget/star_rating_widget.dart';
import 'package:flutter/material.dart';

class AuthorRatingWidget extends StatelessWidget {
  final Map<String, dynamic> author;

  const AuthorRatingWidget({super.key, required this.author});

  @override
  Widget build(BuildContext context) {
    final rating = author['ratings_average'] as num;
    final ratingCount = author['ratings_count'];
    final ratingDistribution = [
      author['ratings_count_1'],
      author['ratings_count_2'],
      author['ratings_count_3'],
      author['ratings_count_4'],
      author['ratings_count_5'],
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.ratings,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              rating.toStringAsFixed(1),
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StarRatingWidget(rating: rating.toDouble()),
                Text(
                  '${AppStrings.basedOn} $ratingCount ${AppStrings.ratings.toLowerCase()}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...List.generate(5, (index) {
          final stars = 5 - index;
          final count = ratingDistribution[stars - 1];
          final percentage =
              ratingCount > 0 ? (count / ratingCount) * 100 : 0.0;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                Text('$stars ${AppStrings.stars}'),
                const SizedBox(width: 8),
                Expanded(
                  child: LinearProgressIndicator(
                    value: percentage / 100,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      getRatingColor(stars),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text('${percentage.toStringAsFixed(1)}%'),
              ],
            ),
          );
        }),
      ],
    );
  }
}
