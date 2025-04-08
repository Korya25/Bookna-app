import 'package:bookna_app/core/resources/app_colors.dart';
import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:bookna_app/features/books/domain/entities/author.dart';
import 'package:flutter/material.dart';

class AuthorReadingStatsWidget extends StatelessWidget {
  final Author author;

  const AuthorReadingStatsWidget({super.key, required this.author});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.readingStats,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _buildStatCard(
              AppStrings.wantToRead,
              author.wantToReadCount.toString(),
              Icons.bookmark,
            ),
            _buildStatCard(
              AppStrings.currentlyReading,
              author.currentlyReadingCount.toString(),
              Icons.menu_book,
            ),
            _buildStatCard(
              AppStrings.alreadyRead,
              author.alreadyReadCount.toString(),
              Icons.check_circle,
            ),
            _buildStatCard(
              AppStrings.totalLogs,
              author.readingLogCount.toString(),
              Icons.library_books,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Card(
      color: AppColors.secondaryBackground,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, size: 30, color: Colors.blue),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontSize: 14, color: AppColors.secondaryText),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
