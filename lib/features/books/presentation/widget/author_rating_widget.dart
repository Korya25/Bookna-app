// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:bookna_app/features/books/domain/entities/author.dart';

class AuthorRatingWidget extends StatelessWidget {
  final Author author;
  final Duration animationDuration;
  final Curve animationCurve;

  const AuthorRatingWidget({
    super.key,
    required this.author,
    this.animationDuration = const Duration(milliseconds: 3000),
    this.animationCurve = Curves.easeOutBack,
  });

  @override
  Widget build(BuildContext context) {
    final ratingCount = author.ratingsCount?.toInt() ?? 0;
    final ratingAverage = author.ratingsAverage?.toDouble();
    final ratingDistribution = [
      author.ratingsCount1?.toInt() ?? 0,
      author.ratingsCount2?.toInt() ?? 0,
      author.ratingsCount3?.toInt() ?? 0,
      author.ratingsCount4?.toInt() ?? 0,
      author.ratingsCount5?.toInt() ?? 0,
    ];

    return SlideInAnimation(
      delay: 0,
      duration: animationDuration,
      curve: animationCurve,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.ratings,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          if (ratingAverage != null || ratingCount > 0) ...[
            _buildRatingHeader(ratingAverage, ratingCount, context),
            const SizedBox(height: 16),
          ] else
            _buildNoRatings(),
          _buildRatingBars(ratingCount, ratingDistribution, context),
        ],
      ),
    );
  }

  Widget _buildRatingHeader(
    double? ratingAverage,
    int ratingCount,
    BuildContext context,
  ) {
    return Row(
      children: [
        if (ratingAverage != null)
          BounceInAnimation(
            delay: 200,
            duration: animationDuration,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: ratingAverage),
              duration: animationDuration,
              curve: Curves.elasticOut,
              builder:
                  (_, value, __) => Text(
                    value.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                    ),
                  ),
            ),
          ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (ratingAverage != null)
              StarRatingWidget(
                rating: ratingAverage,
                animate: true,
                duration: animationDuration,
                delay: 300,
              ),
            if (ratingCount > 0)
              FadeInAnimation(
                delay: 400,
                duration: animationDuration,
                child: TweenAnimationBuilder<int>(
                  tween: IntTween(begin: 0, end: ratingCount),
                  duration: animationDuration,
                  builder:
                      (_, value, __) => Text(
                        '${AppStrings.basedOn} $value ${AppStrings.ratings.toLowerCase()}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildNoRatings() {
    return FadeInAnimation(
      delay: 100,
      duration: animationDuration,
      child: Text(
        AppStrings.noRatingsAvailable,
        style: TextStyle(color: Colors.grey[600]),
      ),
    );
  }

  Widget _buildRatingBars(
    int ratingCount,
    List<int> ratingDistribution,
    BuildContext context,
  ) {
    return Column(
      children: List.generate(5, (index) {
        final stars = 5 - index;
        final count = ratingDistribution[stars - 1];
        final percentage = ratingCount > 0 ? (count / ratingCount) * 100 : 0.0;

        return _buildRatingBar(stars, percentage, index);
      }),
    );
  }

  Widget _buildRatingBar(int stars, double percentage, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          ScaleAnimation(
            delay: 500 + (index * 100),
            duration: animationDuration,
            child: Text('$stars ${AppStrings.stars}'),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(4),
              ),
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: animationDuration,
                curve: animationCurve,
                builder:
                    (_, value, __) => FractionallySizedBox(
                      widthFactor: value,
                      alignment: Alignment.centerLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          color: getRatingColor(stars),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          BounceInAnimation(
            delay: 600 + (index * 100),
            duration: animationDuration,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: percentage),
              duration: animationDuration,
              builder:
                  (_, value, __) => Text(
                    '${value.toStringAsFixed(1)}%',
                    style: TextStyle(
                      color: getRatingColor(stars).withOpacity(0.8),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Color getRatingColor(int stars) {
    const colors = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.lightGreen,
      Colors.green,
    ];
    return colors[stars - 1];
  }
}

// StarRatingWidget remains the same as in your code
class StarRatingWidget extends StatelessWidget {
  final double rating;
  final bool animate;
  final Duration duration;
  final int delay;

  const StarRatingWidget({
    super.key,
    required this.rating,
    this.animate = false,
    this.duration = const Duration(milliseconds: 500),
    this.delay = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        final star = _buildStar(index);
        return animate
            ? BounceInAnimation(
              delay: delay + (index * 100),
              duration: duration,
              child: star,
            )
            : star;
      }),
    );
  }

  Widget _buildStar(int index) {
    if (index < rating.floor()) {
      return const Icon(Icons.star, color: Colors.amber, size: 20);
    } else if (index < rating.ceil()) {
      return const Icon(Icons.star_half, color: Colors.amber, size: 20);
    } else {
      return const Icon(Icons.star_border, color: Colors.amber, size: 20);
    }
  }
}

// Animation Widgets
class SlideInAnimation extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final int delay;
  final Curve curve;

  const SlideInAnimation({
    super.key,
    required this.child,
    required this.duration,
    this.delay = 0,
    this.curve = Curves.easeOut,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween<Offset>(begin: const Offset(-1.0, 0), end: Offset.zero),
      duration: duration,
      curve: Interval(
        delay / (delay + duration.inMilliseconds),
        1.0,
        curve: curve,
      ),
      child: child,
      builder:
          (_, value, child) => Transform.translate(offset: value, child: child),
    );
  }
}

class FadeInAnimation extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final int delay;

  const FadeInAnimation({
    super.key,
    required this.child,
    required this.duration,
    this.delay = 0,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration,
      curve: Interval(
        delay / (delay + duration.inMilliseconds),
        1.0,
        curve: Curves.easeIn,
      ),
      builder: (_, value, child) => Opacity(opacity: value, child: child),
      child: child,
    );
  }
}

class BounceInAnimation extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final int delay;

  const BounceInAnimation({
    super.key,
    required this.child,
    required this.duration,
    this.delay = 0,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration,
      curve: Interval(
        delay / (delay + duration.inMilliseconds),
        1.0,
        curve: Curves.elasticOut,
      ),
      builder: (_, value, child) => Transform.scale(scale: value, child: child),
      child: child,
    );
  }
}

class ScaleAnimation extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final int delay;

  const ScaleAnimation({
    super.key,
    required this.child,
    required this.duration,
    this.delay = 0,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration,
      curve: Interval(
        delay / (delay + duration.inMilliseconds),
        1.0,
        curve: Curves.easeOutBack,
      ),
      builder: (_, value, child) => Transform.scale(scale: value, child: child),
      child: child,
    );
  }
}
