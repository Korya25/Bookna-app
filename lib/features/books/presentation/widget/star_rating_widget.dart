import 'package:bookna_app/core/resources/app_values.dart';
import 'package:flutter/material.dart';

class StarRatingWidget extends StatelessWidget {
  final double rating;

  const StarRatingWidget({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return const Icon(
            Icons.star,
            color: Colors.amber,
            size: AppIconSize.s20,
          );
        } else if (index < rating.ceil()) {
          return const Icon(
            Icons.star_half,
            color: Colors.amber,
            size: AppIconSize.s20,
          );
        } else {
          return const Icon(
            Icons.star_border,
            color: Colors.amber,
            size: AppIconSize.s20,
          );
        }
      }),
    );
  }
}
