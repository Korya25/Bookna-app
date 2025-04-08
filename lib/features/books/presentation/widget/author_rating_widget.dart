import 'package:bookna_app/core/resources/app_colors.dart';
import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:bookna_app/features/books/domain/entities/author.dart';
import 'package:bookna_app/features/books/presentation/widget/star_rating_widget.dart';
import 'package:flutter/material.dart';

class AuthorRatingWidget extends StatelessWidget {
  final Author author;

  const AuthorRatingWidget({super.key, required this.author});

  @override
  Widget build(BuildContext context) {
    final ratingCount = author.ratingsCount ?? 0;
    final ratingDistribution = [
      author.ratingsCount1 ?? 0,
      author.ratingsCount2 ?? 0,
      author.ratingsCount3 ?? 0,
      author.ratingsCount4 ?? 0,
      author.ratingsCount5 ?? 0,
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
            if (author.ratingsAverage != null)
              Text(
                author.ratingsAverage.toString(),
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
                if (author.ratingsAverage != null)
                  StarRatingWidget(rating: author.ratingsAverage!.toDouble()),
                if (ratingCount > 0)
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
